# make sure Grammar pickle files are present
import os
from os.path import dirname, isfile, join
for fn in ('Grammar2.7.13.final.0.pickle',
           'PatternGrammar2.7.13.final.0.pickle'):
    assert isfile(join(dirname(os.__file__), 'lib2to3', fn))

import platform
import sys
import subprocess
from pprint import pprint

# it is important to run the test for the 2to3 command *after* the existance
# of the Grammar pickle files has been checked (because running 2to3) will
# create them
subprocess.check_call([join(sys.prefix,
      'Scripts/2to3.exe' if sys.platform == 'win32' else 'bin/2to3'), '-h'])

armv7l = bool(platform.machine() == 'armv7l')
ppc64le = bool(platform.machine() == 'ppc64le')
debug = int(os.getenv('DEBUG', 0))

print('Python version: %s' % platform.python_version())
assert platform.python_version() == '2.7.13'
assert sys.version_info[:3] == (2, 7, 13)
if sys.platform == 'win32':
    assert 'MSC v.1500' in sys.version
print('max unicode: %d' % sys.maxunicode)
print('architecture: %s' % repr(platform.architecture()))
print('sys.version: %s' % sys.version)
print('platform.machine(): %s' % platform.machine())
print('DEBUG: %s' % debug)

assert hasattr(sys, 'gettotalrefcount') == bool(debug)
if debug:
    print('sys.gettotalrefcount: %d' % sys.gettotalrefcount())

import _bisect
import _codecs_cn
import _codecs_hk
import _codecs_iso2022
import _codecs_jp
import _codecs_kr
import _codecs_tw
import _collections
import _csv
import _ctypes
import _ctypes_test
import _elementtree
import _functools
import _hashlib
import _heapq
import _hotshot
import _io
import _json
import _locale
import _lsprof
import _multibytecodec
import _multiprocessing
import _random
import _socket
import _sqlite3
import _ssl
import _struct
import _testcapi
import array
import audioop
import binascii
import bz2
import cPickle
import cStringIO
import cmath
import datetime
import future_builtins
import hashlib
import itertools
import math
import mmap
import operator
import parser
import pyexpat
#import resource
import select
import ssl
import strop
#import syslog
import time
import unicodedata
import xmlrpclib
import zlib
import gzip
from os import urandom

for mode, res in [
    ('md5', 'd41d8cd98f00b204e9800998ecf8427e'),
    ('sha1', 'da39a3ee5e6b4b0d3255bfef95601890afd80709'),
    ('sha224', 'd14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f'),
    ('sha256', 'e3b0c44298fc1c149afbf4c8996fb924'
               '27ae41e4649b934ca495991b7852b855'),
    ('sha384', '38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf'
               '63f6e1da274edebfe76f65fbd51ad2f14898b95b'),
    ('sha512', 'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921'
               'd36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81'
               'a538327af927da3e'),
    ]:
    h = hashlib.new(mode)
    assert h.hexdigest() == res

a = 20 * 'Ilan'
b = 'x\x9c\xf3\xccI\xcc\xf3\xa4"\x06\x00\xc8L\x1eQ'
assert zlib.compress(a) == b
assert zlib.decompress(b) == a
with gzip.open('x.gz', 'wb') as fo:
    fo.write(a)
with open('x.gz', 'rb') as fi:
    assert len(fi.read()) == 29
with gzip.open('hello.txt.gz', 'rb') as fi:
    assert fi.read() == 'Hello World!\n'

if sys.platform != 'win32':
    if not (ppc64le or armv7l):
        import _curses
        import _curses_panel
    import crypt
    import fcntl
    import grp
    import nis
    import readline
    import termios

    from distutils import sysconfig
    for var_name in 'LDSHARED', 'CC':
        value = sysconfig.get_config_var(var_name)
        assert value.split()[0] == 'gcc', value
    value = sysconfig.get_config_var('CXX')
    assert value.split()[0] == 'g++', value
    readline.clear_history()

if not (armv7l or ppc64le):
    import _tkinter
    import Tkinter
    import turtle
    print('TK_VERSION: %s' % _tkinter.TK_VERSION)
    print('TCL_VERSION: %s' % _tkinter.TCL_VERSION)
    assert _tkinter.TK_VERSION == _tkinter.TCL_VERSION == '8.5'

print('OPENSSL_VERSION: %s' % ssl.OPENSSL_VERSION)
if sys.platform != 'win32':
    assert '1.0.2l' in ssl.OPENSSL_VERSION

pprint(platform._sys_version())
sys.version = ('2.7.6 (#1, Jan  9 2013, 06:47:03)\n'
               '[GCC 4.1.2 20080704 (Red Hat 4.1.2-54)] on linux2')
assert platform._sys_version() == ('CPython', '2.7.6', '', '', '1',
                                   'Jan  9 2013 06:47:03',
                                   'GCC 4.1.2 20080704 (Red Hat 4.1.2-54)')

if int(os.getenv('GUI_TEST', 0)):
    turtle.forward(100)
