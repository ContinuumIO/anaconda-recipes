#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

rm $PREFIX/bin/py.test*
rm -f $SP_DIR/__pycache__/pkg_res*
