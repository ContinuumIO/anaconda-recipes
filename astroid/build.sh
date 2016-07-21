#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

# contains Python 2 and 3 code, which breaks conda-build
rm -rf $SP_DIR/astroid/tests/testdata/
