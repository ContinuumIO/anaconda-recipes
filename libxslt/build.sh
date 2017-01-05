#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

./configure $B \
    --with-libxml-prefix=$PREFIX \
    --without-crypto \
    --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share/doc
