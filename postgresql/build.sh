#!/bin/bash

export CFLAGS="$CFLAGS -I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

if [ `uname` == Linux ]; then
    COP="--with-openssl"
fi

./configure --without-readline $COP --prefix=$PREFIX

make
make install
