#!/bin/bash

rm -f transaction/*~
rm -f transaction/tests/*~

$PYTHON setup.py install --old-and-unmanageable
