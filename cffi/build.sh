#!/bin/bash

if [ `uname` == Linux ]; then
    rm $PREFIX/lib/pkgconfig/libffi.pc
fi

$PYTHON setup.py install --old-and-unmanageable
