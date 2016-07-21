#!/bin/bash

export HDF5_DIR=$PREFIX
export NETCDF4_DIR=$PREFIX
export ZLIB_DIR=$PREFIX

if [ `uname` == Darwin ]; then
    export LDFLAGS="-lnetcdf -L$PREFIX/lib $LDFLAGS"
fi

$PYTHON setup.py install
