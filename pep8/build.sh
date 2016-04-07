#!/bin/bash

$PYTHON setup.py install

rm -f $SP_DIR/__pycache__/pkg_res*
