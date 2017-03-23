#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

rm -r $SP_DIR/tests
