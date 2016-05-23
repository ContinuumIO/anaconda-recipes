#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable
rm $PREFIX/bin/coverage*
