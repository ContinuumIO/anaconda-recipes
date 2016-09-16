#!/bin/bash

$PYTHON setup.py install
mkdir -p $SP_DIR/notebook/static
cp -r static/pivot-ajax $SP_DIR/notebook/static
cp -r static/pivottable $SP_DIR/notebook/static
