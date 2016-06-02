#!/bin/bash

$PYTHON setup.py install

#    $REPLACE "distutils.core" "setuptools" setup.py
#
#    unset CONDA_BUILD
#    $PREFIX/bin/easy_install wheel
#    $PYTHON setup.py bdist_wheel
#
#    mv dist/pycosat-*.whl $HOME/wheels
#
#    echo "==========================================="
#    echo "Please find the wheel package in ~/wheels"
#    echo "==========================================="
#    exit 1
