import os
import ruamel_yaml
try:
    import pytest
except ImportError:
    pytest = None

if pytest:
    print('ruamel_yaml.__version__: %s' % ruamel_yaml.__version__)
