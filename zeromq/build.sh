#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

./configure $B \
    --prefix=$PREFIX \
    --with-libsodium=$PREFIX \
    --without-documentation
make
make install

rm -rf $PREFIX/share
rm -rf $PREFIX/src
rm -rf $PREFIX/etc
rm -rf $PREFIX/Library
