#!/bin/bash

$PYTHON setup.py install

rm -rf $SP_DIR/__pycache__
rm $SP_DIR/jupyter.py*
