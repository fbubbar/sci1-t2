from . import log, np, pd, plt
from scipy.fftpack import fft, fftfreq
from scipy.optimize import curve_fit

def norm(x, amp, mu, sig):
    return amp * np.exp(-(x-mu)**2 / (2*sig**2))

def get_freq(trial, plot_spectrum=False):
    wi = trial['Gyroscope x (rad/s)']

    N = len(wi)
    T = 1/100 # [s]

    yf = fft(wi.values)
    xf = fftfreq(N, T)[:N//2]   # positive frequencies
    magnitudes = abs(yf[:N//2]) # magnitude spectrum

    # identify dominant frequency
    dom_i = np.argmax(magnitudes)
    dom_freq = xf[dom_i]
    dom_mag = magnitudes[dom_i]

    # calculate peak-to-noise ratio
    noise_mag = np.delete(magnitudes, dom_i)
    noise_level = np.mean(noise_mag)
    ptnr = dom_mag / noise_level if noise_level != 0 else np.inf

    # fit a normal distribution to estimate the peak and uncertainty
    fit_radius = 3
    low_i = max(0, dom_i - fit_radius)
    high_i = min(len(xf), dom_i + fit_radius + 1)
    fit_range = slice(low_i, high_i)
    (_amp, freq, dfreq), _ = curve_fit(norm, xf[fit_range], 
                                       magnitudes[fit_range], 
                                       p0=[dom_mag, dom_freq, 1.])

    if plot_spectrum:
        plt.plot(xf, magnitudes, 'o', label='Freqency Spectrum')
        norm_xs = np.linspace(xf[low_i], xf[high_i], 1000)
        plt.plot(norm_xs, norm(norm_xs, _amp, freq, dfreq), label='Error Model')
        plt.xlabel('Frequency [Hz]')
        plt.ylabel('Magnitude')
        plt.show()

    return freq, dfreq, ptnr


def fourier_trial_freqs(trials, trials_meta, plot_spectra=False):
    period_data = pd.DataFrame(columns=['f', 'df', 'T', 'dT', 'ptnr'])
    for i, (trial, meta) in enumerate(zip(trials, trials_meta)):
        j, src, comment = meta
        if isinstance(comment, str) and 'intermediate' in comment.lower():
            freq, dfreq, ptnr = get_freq(trial, plot_spectrum=plot_spectra)
            T, dT = 1/freq, dfreq/freq**2
            period_data.loc[i] = [freq, dfreq, T, dT, ptnr]

            # log the results
            print(f'Results for segment {j} of {src}:')
            print(f"-> dominant frequency: {freq:.2f} ± {dfreq:.2f} Hz")
            print(f"-> period: {T:.4f} ± {dT:.4f} seconds")
            print(f"-> peak-to-noise ratio: {ptnr:.2f}")
        else:
            log.info(f"Skipping segment {j} of '{src}' ...")

    return period_data


def point_method(trial, plot_points=False):
    wi = trial['Gyroscope x (rad/s)']
    time = trial['Time (s)']

    end_indices = np.sign(wi).diff().fillna(0) != 0
    start_indices = list(end_indices[1:]) + [False]

    x1 = np.array(time[start_indices])
    x2 = np.array(time[end_indices])
    y1 = np.array(wi[start_indices])
    y2 = np.array(wi[end_indices])
    zero_times = x1 - y1*(x2-x1)/(y2-y1)
    
    n = 5 # window size
    local_min_i = wi == wi.rolling(n, center=True).min()
    local_max_i = wi == wi.rolling(n, center=True).max()
    local_min_t = time[local_min_i]
    local_max_t = time[local_max_i]

    all_times = np.concatenate([zero_times, local_min_t, local_max_t])
    diffs = np.diff(np.sort(all_times))

    if len(diffs) == 0:
        log.warning('zero method returned no results')
        return None, None
    elif len(diffs) == 1:
        T, dT = diffs[0] * 4, np.inf
    else:
        T, dT = diffs.mean() * 4, diffs.std() * 4

    if plot_points:
        plt.plot(time, wi)
        plt.scatter(local_min_t, wi[local_min_i], c='r')
        plt.scatter(local_max_t, wi[local_max_i], c='g')
        plt.scatter(zero_times, np.zeros_like(zero_times), c='b')

        plt.xlabel('Time [s]')
        plt.ylabel('Angular Velocity [rad/s]')
        plt.show()

    return T, dT


def point_trial_periods(trials, trials_meta, plot_points=False):
    period_data = pd.DataFrame(columns=['omega0', 'T', 'dT', 'rel_err'])
    for i, (trial, meta) in enumerate(zip(trials, trials_meta)):
        j, src, comment = meta
        if isinstance(comment, str) and 'intermediate' in comment.lower():
            omega0 = trial['Gyroscope x (rad/s)'].abs().max()

            T, dT = point_method(trial, plot_points=plot_points)
            if T and dT:
                rel_dT = dT/T * 100
                period_data.loc[i] = [omega0, T, dT, rel_dT]

                # log the results
                print(f'Results for segment {j} of {src}:')
                print(f'-> initial angular speed: {omega0:.2f} rad/s')
                print(f'-> period: {T:.4f} ± {dT:.4f} seconds (rel. {rel_dT:.2f}%)')
                continue
        
        log.info(f"Skipping segment {j} of '{src}' ...")

    return period_data

