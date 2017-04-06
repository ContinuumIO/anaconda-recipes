#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

touch $SP_DIR/tabpy_server/__init__.py
