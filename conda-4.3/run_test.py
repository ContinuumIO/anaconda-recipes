import conda

print('conda.__version__: %s' % conda.__version__)
assert conda.__version__ == '4.3.19'

from conda.fetch import handle_proxy_407
