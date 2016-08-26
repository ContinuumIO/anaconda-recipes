import sys
from os.path import expanduser

import conda_api


assert (conda_api.split_canonical_name('redis-py-2.4.3-py27_0') ==
        ('redis-py', '2.4.3', 'py27_0'))

print('conda_api.__version__: %s' % conda_api.__version__)

if sys.platform == 'win32':
    root_prefix = r'C:\Python27'
else:
    root_prefix = expanduser('~/minonda')

conda_api.set_root_prefix(root_prefix)
conda_api.test()

assert conda_api.__version__ == '1.1.0'
