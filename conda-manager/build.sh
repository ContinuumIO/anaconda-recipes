#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

rm -rf $SP_DIR/spyplugins
rm -f $SP_DIR/conda_manager-*-nspkg.pth
