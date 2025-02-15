
# expose common imports
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# suppress SettingWithCopyWarning
pd.options.mode.chained_assignment = None

# set up logging
import logging
from sys import stdout

logging.basicConfig(stream=stdout, level=logging.INFO, format='[%(levelname)s] %(message)s')
log = logging.getLogger()

