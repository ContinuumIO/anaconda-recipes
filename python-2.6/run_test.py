import os
from os.path import dirname, isfile, join
for fn in 'Grammar2.6.9.final.0.pickle', 'PatternGrammar2.6.9.final.0.pickle':
    assert isfile(join(dirname(os.__file__), 'lib2to3', fn))

import platform
import sys
import subprocess

# it is important to run the test for the 2to3 command *after* the existance
# of the Grammar pickle files has been checked (because running 2to3) will
# create them
subprocess.check_call([join(sys.prefix,
      'Scripts/2to3.exe' if sys.platform == 'win32' else 'bin/2to3'), '-h'])

print 'Python version:', platform.python_version()
print 'max unicode:', sys.maxunicode
print 'architecture:', platform.architecture()
print 'sys.version:', sys.version

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
import _tkinter
import array
import audioop
import binascii
import bz2
import cPickle
import cStringIO
import cmath
import datetime
import future_builtins
import itertools
import math
import mmap
import operator
import parser
import pyexpat
import select
import strop
import time
import unicodedata
import zlib
from os import urandom

if sys.platform != 'win32':
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
    for var_name in 'LDSHARED', 'CC':
        value = sysconfig.get_config_var(var_name)
        assert value.split()[0] == 'gcc', value

if 1:
    import Tkinter
    import turtle
    print 'TK_VERSION:', _tkinter.TK_VERSION
    print 'TCL_VERSION:', _tkinter.TCL_VERSION
    assert _tkinter.TK_VERSION == _tkinter.TCL_VERSION == '8.5'

import platform
platform.python_version()
