import conda_build

print('conda_build.__version__: %s' % conda_build.__version__)
assert conda_build.__version__.startswith('2.0')
