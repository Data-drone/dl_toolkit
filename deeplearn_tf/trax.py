from IPython.terminal.embed import InteractiveShellEmbed


ipshell = InteractiveShellEmbed()
ipshell.dummy_mode = True

import os
import numpy as np

print('\nInstall Trax:')
ipshell.magic("%pip install -q -U trax")
import trax
