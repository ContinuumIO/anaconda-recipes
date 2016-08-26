#!/bin/bash

if [ `uname -m` == armv6l ]; then
    export CC='gcc -O0'
fi

$PYTHON setup.py install --with-xslt-config=$PREFIX/bin/xslt-config
