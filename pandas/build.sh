#!/bin/bash

if [ `uname` == Darwin ]; then
    LDFLAGS="${LDFLAGS} -headerpad_max_install_names"
fi

$PYTHON -c 'import cython; assert cython.__version__ >= "0.25"'

$PYTHON setup.py install --old-and-unmanageable
