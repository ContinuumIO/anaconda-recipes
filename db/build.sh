#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

cd build_unix
../dist/configure $B --prefix=$PREFIX
make
make install

cd $PREFIX
rm -rf docs
