#!/bin/bash

BP=$SP_DIR/zope
mkdir $BP
cp $RECIPE_DIR/__init__.py $BP/
$PYTHON -c "import zope"
