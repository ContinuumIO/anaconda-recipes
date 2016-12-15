# This module is used for testing by conda when setting CIO_TEST
import os

level = int(os.getenv('CIO_TEST') or 0)

base_urls = []
if level <= 3:
    if level >= 1:
        base_urls.extend(['http://bremen/pkgs/pro',
                          'http://bremen/pkgs/free'])
    if level >= 2:
        base_urls.insert(0, 'http://bremen/test-pkgs')
    if level == 3:
        base_urls.insert(0, 'http://bremen/test-pkgs-%s' % os.getenv('USER'))

if level == 4:
    base_urls = ['https://repo.continuum.io/pkgs/free',
                 'http://testrepo.continuum.io/test-pkgs']

if os.getenv("CONDA_CHANNELS") is None and base_urls:
    os.environ["CONDA_CHANNELS"] = ','.join(base_urls)
