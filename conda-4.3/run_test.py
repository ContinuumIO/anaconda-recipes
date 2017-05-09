import conda

print('conda.__version__: %s' % conda.__version__)
assert conda.__version__ == '4.3.17'

from conda.fetch import handle_proxy_407
