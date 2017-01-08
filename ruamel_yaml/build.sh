#!/bin/bash

cp $RECIPE_DIR/__init__.py $SRC_DIR/
cp $RECIPE_DIR/setup.py $SRC_DIR/

$PYTHON setup.py install

rm $SP_DIR/*.egg*
