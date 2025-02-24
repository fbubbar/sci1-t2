
import numpy as np

data = np.array([
    53.81,
    54.70,
    52.26,
    53.04,
    53.49,
    52.68,
    51.07,
    53.04,
    52.32
])

T = np.mean(data * 2)
dT = np.std(data * 2)

Iz = 0.00044388566666666673

kappa = 4 * np.pi**2 * Iz / T**2
dkappa = dT * 8 * np.pi**2 * Iz / T**3

print(kappa, dkappa, dkappa/kappa)


