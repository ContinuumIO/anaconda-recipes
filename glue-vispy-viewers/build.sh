#!/bin/bash

$PYTHON setup.py install --single-version-externally-managed --record record.txt

rm -rf $SP_DIR/PyQt5
