#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

./configure $B \
    --enable-shared=yes \
    --enable-static=yes \
    --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share
