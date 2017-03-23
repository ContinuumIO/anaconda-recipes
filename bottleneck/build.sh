#!/bin/bash

if [[ `uname` == Linux ]]; then
    export CFLAGS="$CFLAGS -std=c99"
fi

$PYTHON setup.py install --old-and-unmanageable
