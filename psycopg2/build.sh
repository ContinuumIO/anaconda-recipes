#!/bin/bash

# remove shared library to force linking statically
if [ `uname` == Linux ]; then
    rm $PREFIX/lib/libpq.so*
else
    rm $PREFIX/lib/libpq*.dylib
fi
# $REPLACE '#static_libpq=1' 'static_libpq=1' setup.cfg
$REPLACE 'have_ssl=0' 'have_ssl=1' setup.cfg

export LDFLAGS="-L$PREFIX/lib -lssl"

$PYTHON setup.py install
