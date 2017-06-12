#!/bin/bash

BP=$SP_DIR/sphinxcontrib
mkdir $BP
cp $RECIPE_DIR/__init__.py $BP/
$PYTHON -c "import sphinxcontrib"
