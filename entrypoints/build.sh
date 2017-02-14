#!/bin/bash

cp $RECIPE_DIR/setup.py $SRC_DIR/

$PYTHON setup.py install
