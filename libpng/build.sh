#!/bin/bash

if [ `uname` == Linux ]; then
    export CFLAGS="-I$PREFIX/include -L$PREFIX/lib"
    export CPPFLAGS="-I$PREFIX/include -L$PREFIX/lib"
fi

./configure --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share
