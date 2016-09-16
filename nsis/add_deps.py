import os
from os.path import join

from bt.source import SRC_URL
from ll.utils import download


BASE_URL = SRC_URL + '/nsis/ansi/'
DST_DIR = join(os.environ['PREFIX'], 'NSIS', 'Plugins', 'x86-ansi')

for line in [
    '431e5b960aa15af5d153bae6ba6b7e87 UAC.dll',
    '11a9ced7037e09ccdab4cb9ca3882359 untgz.dll',
    '7178d69ded53b7683dd52cd1ca0a20ff elevate.exe',
    '7597202a271542d50e9d1e305a96e485 nsPython.dll',
    ]:
    md5, fn = line.split()
    download(BASE_URL + fn, join(DST_DIR, fn), md5, verbose=True)
