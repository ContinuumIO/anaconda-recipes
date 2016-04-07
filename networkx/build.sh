#!/bin/bash

$PYTHON setup.py install
rm -rf $SP_DIR/networkx*.egg/share
