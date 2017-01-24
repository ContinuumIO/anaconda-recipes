import conda
import cio_test

print('conda.__version__: %s' % conda.__version__)
assert conda.__version__ == '4.3.8'

from conda.fetch import handle_proxy_407
