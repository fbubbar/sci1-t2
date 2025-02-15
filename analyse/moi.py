
from . import np

# x,y,z in [m]
# m in [kg]
def box_moi(x, y, z, m):
    c = 1/12
    Ix = c * m * (y**2 + z**2)
    Iy = c * m * (x**2 + z**2)
    Iz = c * m * (x**2 + y**2)
    return (Ix, Iy, Iz)

def add_angular_momentum(trial, I):
    Ix, Iy, Iz = I
    trial['Lx'] = trial.apply(lambda r: r['Gyroscope x (rad/s)'] * Ix, axis=1)
    trial['Ly'] = trial.apply(lambda r: r['Gyroscope y (rad/s)'] * Iy, axis=1)
    trial['Lz'] = trial.apply(lambda r: r['Gyroscope z (rad/s)'] * Iz, axis=1)
    trial['L'] = trial.apply(lambda r: np.linalg.norm((r['Lx'], r['Ly'], r['Lz'])), axis=1)
