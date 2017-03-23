# make sure Grammar pickle files are present
import os
from os.path import dirname, isfile, join
for fn in 'Grammar3.4.5.final.0.pickle', 'PatternGrammar3.4.5.final.0.pickle':
    assert isfile(join(dirname(os.__file__), 'lib2to3', fn))

import platform
import sys
import subprocess

# it is important to run the test for the 2to3 command *after* the existance
# of the Grammar pickle files has been checked (because running 2to3) will
# create them
subprocess.check_call([join(sys.prefix,
      'Scripts/2to3.exe' if sys.platform == 'win32' else 'bin/2to3'), '-h'])

armv6l = bool(platform.machine() == 'armv6l')
armv7l = bool(platform.machine() == 'armv7l')
ppc64le = bool(platform.machine() == 'ppc64le')

print('sys.version:', sys.version)
print('sys.platform:', sys.platform)
print('tuple.__itemsize__:', tuple.__itemsize__)
if sys.platform == 'win32':
    assert 'MSC v.1600' in sys.version
print('sys.maxunicode:', sys.maxunicode)
print('platform.architecture:', platform.architecture())
print('platform.python_version:', platform.python_version())
assert platform.python_version() == '3.4.5'
assert sys.version_info[:3] == (3, 4, 5)

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
import _decimal
import _elementtree
import _functools
import _hashlib
import _heapq
import _io
import _json
import _locale
import _lsprof
import _lzma
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
import cmath
import datetime
import itertools
import lzma
import math
import mmap
import operator
import parser
import pyexpat
import select
import ssl
import time
import unicodedata
import zlib
from os import urandom

t = 100 * b'Foo '
assert lzma.decompress(lzma.compress(t)) == t

if sys.platform != 'win32':
    if not (ppc64le or armv7l):
        import _curses
        import _curses_panel
    import crypt
    import fcntl
    import grp
    import nis
    import readline
    import resource
    import syslog
    import termios

    from distutils import sysconfig

if sys.platform == 'linux':
    for var_name in 'LDSHARED', 'CC':
        value = sysconfig.get_config_var(var_name)
        assert value.split()[0] == 'gcc', value
    for var_name in 'LDCXXSHARED', 'CXX':
        value = sysconfig.get_config_var(var_name)
        assert value.split()[0] == 'g++', value

if not (armv6l or armv7l or ppc64le):
    import tkinter
    import turtle
    import _tkinter
    print('TK_VERSION: %s' % _tkinter.TK_VERSION)
    print('TCL_VERSION: %s' % _tkinter.TCL_VERSION)
    TCLTK_VER = '8.6' if sys.platform == 'win32' else '8.5'
    assert _tkinter.TK_VERSION == _tkinter.TCL_VERSION == TCLTK_VER

print('OPENSSL_VERSION:', ssl.OPENSSL_VERSION)
if sys.platform != 'win32':
    assert '1.0.2k' in ssl.OPENSSL_VERSION
