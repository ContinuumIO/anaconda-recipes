#!/bin/bash

export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"

mkdir -p $PREFIX/bin

./configure --prefix=$PREFIX --enable-utf
make
make install

rm -rf $PREFIX/share
