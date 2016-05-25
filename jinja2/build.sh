#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

rm -rf $SP_DIR/__pycache__/pkg_res*
