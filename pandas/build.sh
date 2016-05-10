#!/bin/bash

if [ `uname` == Darwin ]; then
    LDFLAGS="${LDFLAGS} -headerpad_max_install_names"
fi

$PYTHON setup.py install --old-and-unmanageable
