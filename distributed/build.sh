#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

cd $PREFIX/bin
rm -f dcenter dcluster dscheduler dworker
