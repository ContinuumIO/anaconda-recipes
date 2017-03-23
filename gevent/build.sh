#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

if [ $PY3K == 0 ]
then
    rm $SP_DIR/gevent/_socket3.py
fi
