
from . import log, pd, plt
from .fourier import get_freq

from glob import glob
from os import path

rootpath = path.relpath(path.join(__file__, '../..'))


def load_files(pat):
    csv_files = glob(f'{rootpath}/data/{pat}/Gyroscope*/Raw Data.csv')

    trials = []
    trials_meta = []
    for f in csv_files:
        t, m = process_csv(f)
        trials.extend(t)
        trials_meta.extend(m)
    
    n_trials = len(trials)
    log.info(f'Found {n_trials} trials in {len(csv_files)} files.')
    return trials, trials_meta


def get_or(df, col, i, default=None):
    res = df[col].get(i, default)
    if not pd.notna(res): res = default
    return res


def process_csv(file):
    log.info(f"Processing '{file}' ...")
    data = pd.read_csv(file)
    datadir = path.dirname(file)

    # load time data
    time_data = pd.read_csv(path.join(datadir, 'meta/time.csv'))
    starts = time_data.loc[time_data['event'] == 'START', 'experiment time'].values
    pauses = time_data.loc[time_data['event'] == 'PAUSE', 'experiment time'].values

    # try to load segments data
    segments_file = path.join(datadir, 'meta/segments.csv')
    if path.isfile(segments_file):
        segments = pd.read_csv(segments_file)
    else:
        # no segments file => empty dataframe
        log.warning(f"cutoffs not found for '{datadir}'")
        segments = pd.DataFrame()

    trials = []
    trials_meta = []

    # go through each segment of this file
    for i, (start, end) in enumerate(zip(starts, pauses)):
        if i in segments['segment'].values:
            # if we have cutoff data, use it to crop the data;
            # otherwise, keep the whole segment
            start = get_or(segments, 'start', i, start)
            end = get_or(segments, 'end', i, end)

            # get the comment if it exists
            comment = get_or(segments, 'comment', i, None)

            # discard segments if specified
            if not segments.keep.get(i, True):
                log.info(f'-> discarding segment {i}' )
                continue

        mask = (data['Time (s)'] >= start) & (data['Time (s)'] <= end)
        trial = data.loc[mask]
        meta = (i, datadir, comment)

        trials.append(trial)
        trials_meta.append(meta)

    return trials, trials_meta


def plot_trials_w(trials, trials_meta):
    w_label = 'Angular Velocity (rad/s)'
    w_cols = [
        'Gyroscope x (rad/s)',
        'Gyroscope y (rad/s)',
        'Gyroscope z (rad/s)',
        'Absolute (rad/s)',
    ]
    for i, t in enumerate(trials):
        plot_trial(i, t, trials_meta[i], w_cols, w_label)

def plot_trials_L(trials, trials_meta):
    L_label = 'Angular momentum [kg m$^2$ s$^{-1}$]'
    L_cols = ['Lx', 'Ly', 'Lz', 'L']
    for i, t in enumerate(trials):
        plot_trial(i, t, trials_meta[i], L_cols, L_label)


def plot_trial(i, trial, meta, cols, ylabel):
    title = f'Trial {i+1}'
    x, y, z, a = cols

    # process metadata
    j, source, comment = meta
    log.info(f"{title}: source '{source}' #{j}")
    if comment:
        log.info(f'Comment: {comment}')
        title = f'{title}: {comment}'

    # make the plot
    plt.figure()
    ax = trial.plot(
        x='Time (s)',
        y=[z, x, y, a], # Iz > Ix > Iy
        color=['#4285f4', '#ea4335', '#fbbc04', 'black']
    )
    ax.legend([
        'Primary Axis',
        'Intermediate Axis',
        'Tertiary Axis',
        'Absolute'
    ])
    ax.set_ylabel(ylabel)
    plt.title(title)
    plt.show()

