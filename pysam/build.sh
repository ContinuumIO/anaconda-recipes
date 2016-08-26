#!/bin/bash

if [ `uname` == Linux ]; then
    export CFLAGS="-I$PREFIX/include -L$PREFIX/lib"
fi

rm ez_setup.*

$PYTHON setup.py install
