#!/bin/bash

BP=$SP_DIR/backports
mkdir $BP
cp $RECIPE_DIR/__init__.py $BP/
$PYTHON -c "import backports"
