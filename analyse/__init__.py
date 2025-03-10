
# expose common imports
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# suppress SettingWithCopyWarning
pd.options.mode.chained_assignment = None

# imports needed for setup
import logging
import time
from sys import stdout
from os import path, makedirs

# set up logging
logging.basicConfig(stream=stdout, level=logging.INFO, format='[%(levelname)s] %(message)s')
log = logging.getLogger()


# set up global configuration
config = {
    'save_figures': False,
    'rootpath': path.relpath(path.join(__file__, '../..')),
}


# set up figure saving
def _ensure_figures_dir():
    figdir = path.join(config['rootpath'], 'figures')
    if not path.isdir(figdir):
        log.info(f'Creating figures directory at {figdir}')
        makedirs(figdir)


def save_figure(name, force=False):
    if config['save_figures'] or force:
        _ensure_figures_dir()
        t = int(time.time())
        figdir = path.join(config['rootpath'], 'figures')
        fname = f'{name}_{t}.svg'
        plt.savefig(path.join(figdir, fname))

