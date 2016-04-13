#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable
rm -f $SP_DIR/backports/__init__*
rm -f $SP_DIR/backports/__pycache__/__init__*
