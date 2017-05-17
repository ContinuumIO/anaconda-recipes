import os
from os.path import join

from bt.source import SRC_URL
from ll.utils import download


BASE_URL = SRC_URL + '/nsis/unicode/'
DST_DIR = join(os.environ['PREFIX'], 'NSIS', 'Plugins', 'x86-unicode')

for line in [
    'c71733d8ef33afcc99050ba2b0c56614 UAC.dll',
    '832c58ba1567ab9dec35e115f0b50e8f untgz.dll',
    '7178d69ded53b7683dd52cd1ca0a20ff elevate.exe',
    'be71dfd1419eb91778cfde6bb8a44320 UnicodePathTest.dll'
    ]:
    md5, fn = line.split()
    download(BASE_URL + fn, join(DST_DIR, fn), md5, verbose=True)
