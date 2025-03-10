from .period import *
from .moi import *
from .process import *
from .num_sim import *

# define constants
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

