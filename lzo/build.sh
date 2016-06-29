#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

./configure $B --prefix=$PREFIX CFLAGS=-fPIC
make
make install

rm -rf $PREFIX/share
