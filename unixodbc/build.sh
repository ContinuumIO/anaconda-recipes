#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

./configure $B \
    --sysconfdir=/etc \
    --prefix=$PREFIX
make
make install
