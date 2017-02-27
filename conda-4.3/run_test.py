import conda
import cio_test

print('conda.__version__: %s' % conda.__version__)
assert conda.__version__.startswith('4.3.13')

from conda.fetch import handle_proxy_407
