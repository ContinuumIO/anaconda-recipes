#!/bin/bash

if [ $PY_VER != 2.7 ]; then
    echo "PY_VER: $PY_VER"
    echo "Please use conda-build with --python=2.7 option"
    exit 1
fi

$PYTHON setup.py install
