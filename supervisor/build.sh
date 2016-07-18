#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

rm $SP_DIR/*-nspkg.pth
