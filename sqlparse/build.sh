#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

cp bin/sqlformat $PREFIX/bin
