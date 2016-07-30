#!/bin/bash

cd python
$PYTHON setup.py install --old-and-unmanageable

rm $SP_DIR/*-nspkg.pth
