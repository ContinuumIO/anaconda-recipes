#!/bin/bash

$PYTHON setup.py install

if [ `uname` == Linux ]; then
    ln -s $SP_DIR/Orange/orange.so $PREFIX/lib/liborange.so
    rm $SP_DIR/Orange/liborange.so
fi
