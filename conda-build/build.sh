#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

cp bdist_conda.py ${PREFIX}/lib/python${PY_VER}/distutils/command
