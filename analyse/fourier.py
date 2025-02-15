
from . import log, np
from scipy.fftpack import fft, fftfreq

def get_freq(trial):
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
    peak_to_noise_ratio = dom_mag / noise_level if noise_level != 0 else np.inf
    period = 1 / dom_freq if dom_freq != 0 else np.inf

    return dom_freq, period, peak_to_noise_ratio


def analyse_trial_freqs(trials, trials_meta):
    for trial, meta in zip(trials, trials_meta):
        j, src, comment = meta
        if 'intermediate' in comment.lower():
            dom_freq, period, ptn = get_freq(trial)
            print()
            print(f'Results for segment {j} of {src}:')
            print(f"-> dominant frequency: {dom_freq:.2f} Hz")
            print(f"-> period: {period:.4f} seconds")
            print(f"-> peak-to-noise ratio: {ptn:.2f}")
            print()
        else:
            log.info(f"Skipping segment {j} of '{src}' ...")

