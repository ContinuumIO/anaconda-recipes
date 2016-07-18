#!/bin/sh

if [ `uname` == Darwin ]; then
    export CC=clang
    export CXX=clang++
fi

./configure --prefix=$PREFIX

make
make install
