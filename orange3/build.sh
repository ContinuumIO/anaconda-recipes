#!/bin/bash

if [ `uname` == Linux ]; then
    export CC=gcc44
    export CXX=g++44
fi

$PYTHON setup.py install --single-version-externally-managed --record=/dev/null
