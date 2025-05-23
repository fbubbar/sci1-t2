
from . import *
from scipy.fftpack import fft, fftfreq

# ----------------
# Define constants
# ----------------

PHONE_MASS = 0.17228 # [kg]
PHONE_DIMS = np.array([71.5, 146.7, 7.4]) * 1e-3 # [m]

# results for the phone-racquet system
# see `moi` directory for the calculations

PRQ_MASS = 0.285 + PHONE_MASS # [kg]
PRQ_I = np.array([
    1.8815656991e-02, # x-axis (from physical pendulum)
    1.3911269930e-03, # y-axis (from torsional pendulum)
    2.0703308161e-02, # z-axis (from physical pendulum)
])

# uncertainties for `PRQ_I`
PRQ_DI = np.array([
    5.6770997052e-03,
    7.6076917011e-05,
    3.8411877481e-03,
])


# ---------
# Functions
# ---------

def simulate(trial, dt):
    I2, I3, I1 = PRQ_I
    I = np.diag([I1, I2, I3])
    wp0 = trial['Gyroscope z (rad/s)'].iloc[0]
    wi0 = trial['Gyroscope x (rad/s)'].iloc[0]
    wt = trial['Gyroscope y (rad/s)'].iloc[0]
    omega0 = np.array([wp0, wi0, wt])
    start = trial['Time (s)'].iloc[0]
    end = trial['Time (s)'].iloc[-1]

    times = np.arange(start, end, dt)
    omega = omega0
    primary_omega = np.zeros(times.size)
    intermediate_omega = np.zeros(times.size)
    tertiary_omega = np.zeros(times.size)
    
    for i in range(times.size):
        # Calculate the angular acceleration at the current time step
        omega_dot = np.zeros(3)
        omega_dot[0] = (I2 - I3) * omega[1] * omega[2] / I1
        omega_dot[1] = (I3 - I1) * omega[0] * omega[2] / I2
        omega_dot[2] = (I1 - I2) * omega[0] * omega[1] / I3

        primary_omega[i] = omega[0]
        intermediate_omega[i] = omega[1]
        tertiary_omega[i] = omega[2]
        
        
        # Update the angular velocities
        omega = omega + omega_dot * dt

    plt.plot(times, primary_omega, label='Primary Axis', color='#4285f4')
    plt.plot(times, intermediate_omega, label='Intermediate Axis', color='#ea4335')
    plt.plot(times, tertiary_omega, label='Tertiary Axis', color='#fbbc04')
    plt.xlabel('Time [s]')
    plt.ylabel('Angular velocity [rad/s]')
    plt.title('Simulated angular velocities')
    plt.legend()
    save_figure('simulation')
    plt.show()

def get_freq(intermediate_omega, dt):
    N = len(intermediate_omega)
    yf = fft(intermediate_omega)
    T = dt
    xf = fftfreq(N, T)[:N//2]   # positive frequencies
    magnitudes = abs(yf[:N//2]) # magnitude spectrum

    # identify dominant frequency
    dom_i = np.argmax(magnitudes)
    dom_freq = xf[dom_i]
    dom_mag = magnitudes[dom_i]

    # calculate peak-to-noise ratio
    noise_mag = np.delete(magnitudes, dom_i)
    noise_level = np.mean(noise_mag)

    peak_to_noise_ratio = dom_mag / noise_level
    period = 1 / dom_freq

    return dom_freq, period, peak_to_noise_ratio

def simulate_period(trial, dt):
    I2, I3, I1 = PRQ_I
    I = np.diag([I1, I2, I3])
    wp0 = trial['Gyroscope z (rad/s)'].iloc[0]
    wi0 = trial['Gyroscope x (rad/s)'].iloc[0]
    wt = trial['Gyroscope y (rad/s)'].iloc[0]
    omega0 = np.array([wp0, wi0, wt])
    start = trial['Time (s)'].iloc[0]
    end = start + 10

    times = np.arange(start, end, dt)
    #print(times.size)
    omega = omega0
    primary_omega = np.zeros(times.size)
    intermediate_omega = np.zeros(times.size)
    tertiary_omega = np.zeros(times.size)
    
    for i in range(times.size):
        # Calculate the angular acceleration at the current time step
        omega_dot = np.zeros(3)
        omega_dot[0] = (I2 - I3) * omega[1] * omega[2] / I1
        omega_dot[1] = (I3 - I1) * omega[0] * omega[2] / I2
        omega_dot[2] = (I1 - I2) * omega[0] * omega[1] / I3

        primary_omega[i] = omega[0]
        intermediate_omega[i] = omega[1]
        tertiary_omega[i] = omega[2]
        
        
        # Update the angular velocities
        omega = omega + omega_dot * dt
    #plt.plot(times, intermediate_omega)
    dom_freq, period, peak_to_noise_ratio = get_freq(intermediate_omega, dt)
    return period