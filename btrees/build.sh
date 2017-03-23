#!/bin/bash

if [ `uname` == Darwin ]; then
    export LDFLAGS="-headerpad_max_install_names $LDFLAGS"
fi

$PYTHON setup.py install --old-and-unmanageable
