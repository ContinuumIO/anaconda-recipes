#!/bin/bash

pushd dbf
rm ver_32.py
if [ $PY3K == 1 ]; then
    rm ver_2.py
else
    rm ver_33.py
fi
popd

$PYTHON setup.py install
