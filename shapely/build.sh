#!/bin/bash

export GEOS_DIR=$PREFIX
export INCLUDEDIR=$PREFIX/include

$PYTHON setup.py install

rm -f $SP_DIR/__pycache__/pkg_res*
