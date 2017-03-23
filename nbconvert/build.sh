#!/bin/bash

rm -rf nbconvert/preprocessors/tests/files/

$PYTHON setup.py install --old-and-unmanageable
