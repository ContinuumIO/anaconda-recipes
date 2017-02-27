# This module is used for testing by conda when setting CIO_TEST
import os

level = int(os.getenv('CIO_TEST') or 0)

BREMEN = 'bremen'

base_urls = []
if level <= 3:
    if level >= 1:
        base_urls.extend(['http://%s/pkgs/pro' % BREMEN,
                          'http://%s/pkgs/free' % BREMEN])
    if level >= 2:
        base_urls.insert(0, 'http://%s/test-pkgs' % BREMEN)
    if level == 3:
        base_urls.insert(0, 'http://%s/test-pkgs-%s' %
                         (BREMEN, os.getenv('USER')))

if level == 4:
    base_urls = ['https://repo.continuum.io/pkgs/free',
                 'http://testrepo.continuum.io/test-pkgs']

if os.getenv("CONDA_CHANNELS") is None and base_urls:
    os.environ["CONDA_CHANNELS"] = ','.join(base_urls)
