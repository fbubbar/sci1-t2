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


def analyse_trial_freqs(trials, trials_meta, plot_spectra=False):
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


