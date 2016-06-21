#!/bin/sh

if [ `uname` == Darwin ]; then
        export CC=clang
        export CXX=clang++
fi

./configure --prefix=$PREFIX \
    --disable-static

make
make install
