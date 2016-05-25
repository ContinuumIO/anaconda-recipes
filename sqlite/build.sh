#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

./configure $B --enable-threadsafe \
    --enable-tempstore \
    --enable-shared=yes \
    --disable-tcl \
    --disable-readline \
    --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share
