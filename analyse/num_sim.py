import numpy as np
import matplotlib.pyplot as plt

def simulate(trial, dt):
    I1, I2, I3 = 0.12, 0.06, 0.03 # kg m^2
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

    plt.plot(times, primary_omega, label='Primary')
    plt.plot(times, intermediate_omega, label='Intermediate')
    plt.plot(times, tertiary_omega, label='Tertiary')
    plt.xlabel('Time (s)')
    plt.ylabel('Angular velocity (rad/s)')
    plt.show()

#simulate(np.array([0, 0, 0]), 0, 10, 0.01)