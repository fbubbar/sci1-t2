
from . import log, pd, plt

from glob import glob
from os import path
from scipy.optimize import curve_fit
import numpy as np
rootpath = path.relpath(path.join(__file__, '../..'))


def load_files(pat, pendulum=False):
    if isinstance(pat, str):
        pats = [pat]
    else:
        pats = pat

    csv_files = []
    for pat in pats:
        csv_files.extend(glob(f"{rootpath}/{'moi/physical' if pendulum else 'data'}/{pat}/Gyroscope*/Raw Data.csv"))

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
            if not segments.keep.get(i, True) or comment == "not a trial":
                log.info(f'-> discarding segment {i}' )
                continue
        else:
            comment = None

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


def fourier_plot_speed_vs_period(trials, period_data):
    # initial speed = maximum gyro x value from `trials`
    omega0s = []
    for trial in trials:
        omega0 = trial['Gyroscope x (rad/s)'].abs().max()
        omega0s.append(omega0)

    # combine the speed data with the period data
    period_data['omega0'] = [omega0s[idx] for idx in period_data.index]

    # make a plot
    plt.title('Period of Unstable Motion')
    plt.xlabel('Initial Angular Speed [rad/s]')
    plt.ylabel('Period [s]')

    plt.errorbar(period_data['omega0'], period_data['T'], 
                 yerr=period_data['dT'], label='Measured',
                 fmt='.', markersize=3, capsize=3)

    plt.legend()
    plt.show()


def plot_speed_vs_period(period_data):
    plt.title('Period of Unstable Motion')
    plt.xlabel('Initial Angular Speed [rad/s]')
    plt.ylabel('Period [s]')

    plt.errorbar(period_data['omega0'], period_data['T'], 
                 yerr=period_data['dT'], label='Measured', 
                 fmt='o', markersize=3, capsize=2)

    plt.legend()
    plt.show()

def fit_model(period_data):
    def model(x, a, b):
        return a * x + b
    num_parameters = 2
    param_bounds=([-np.inf, -np.inf],[np.inf,np.inf])  
    initial_param=(0,0) 
    speed = period_data['omega0']
    period = period_data['T']
    period_err = period_data['dT']
    # make model
    optimized_parameters, covariance_matrix = curve_fit(model, speed, period,
                                                        sigma=period_err,absolute_sigma=True,
                                                        bounds=param_bounds,p0=initial_param)
    parameter_errors = np.sqrt(np.diag(covariance_matrix))
    for i in range(len(optimized_parameters)):
        log.info(f'Parameter #{i+1}: {optimized_parameters[i]:.6e} ± {parameter_errors[i]:.1e}, relative error: {parameter_errors[i]/optimized_parameters[i]:.2f}')
    # plot model
    xForLine = np.linspace(0, max(speed)+0.5, 200)
    yForLine = model(xForLine, *optimized_parameters)
    plt.errorbar(speed, period, yerr=period_err, fmt='o', markersize=3, capsize=2)
    plt.plot(xForLine, yForLine, label='Fit')
    plt.xlabel('Initial Angular Speed [rad/s]')
    plt.ylabel('Period [s]')
    plt.legend()
    plt.show()
    # residuals plot
    residuals = period - model(speed, *optimized_parameters)
    plt.errorbar(speed, residuals, yerr=period_err, fmt='o', markersize=3, capsize=2)
    plt.axhline(0, color='black', linewidth=1)
    plt.xlabel('Initial Angular Speed [rad/s]')
    plt.ylabel('Residuals [s]')
    plt.show()
    # chi squared
    n_dof = len(speed) - num_parameters -1
    ru = residuals/period_err
    chisq = np.sum(np.power(ru,2)) / n_dof
    log.info(f'Chi squared: {chisq:.2f}')

    