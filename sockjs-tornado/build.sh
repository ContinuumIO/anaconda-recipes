#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

rm $SP_DIR/*.pth
rm $SP_DIR/sockjs/__init__.py
touch $SP_DIR/sockjs/__init__.py
