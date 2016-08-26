#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    LDFLAGS="-Wl,-rpath,$PREFIX/lib $LDFLAGS"
fi

./configure \
    --prefix=$PREFIX \
    --without-readline \
    --with-libraries=$PREFIX/lib \
    --with-includes=$PREFIX/include \
    --enable-rpath \
    --with-openssl

make
make install
