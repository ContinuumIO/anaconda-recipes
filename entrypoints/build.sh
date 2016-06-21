#!/bin/bash

mv entrypoints.py $SP_DIR/

$PYTHON -c 'import entrypoints'
