#!/bin/bash

if [ `uname` == Darwin ]; then
    echo "ERROR: ***** This package should not be build on Darwin *****"
    exit 1
fi

./configure \
    --sysconfdir=/etc \
    --prefix=$PREFIX
make
make install
