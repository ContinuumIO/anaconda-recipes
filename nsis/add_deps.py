import os
from os.path import join

from bt.source import SRC_URL
from ll.utils import download


BASE_URL = SRC_URL + '/nsis/unicode/'
DST_DIR = join(os.environ['PREFIX'], 'NSIS', 'Plugins', 'x86-unicode')

for line in [
    'c71733d8ef33afcc99050ba2b0c56614 UAC.dll',
    '510ebd8aa97c4cdbea1f732ca55f5b11 untgz.dll',
    '7178d69ded53b7683dd52cd1ca0a20ff elevate.exe',
    'ed536b07064058681a9e878eb0d11462 UnicodePathTest.dll'
    ]:
    md5, fn = line.split()
    download(BASE_URL + fn, join(DST_DIR, fn), md5, verbose=True)
