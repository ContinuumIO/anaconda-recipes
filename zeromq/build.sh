#!/bin/bash

./configure --prefix=$PREFIX --with-libsodium=$PREFIX --without-documentation
make
make install

rm -rf $PREFIX/share
rm -rf $PREFIX/src
rm -rf $PREFIX/etc
rm -rf $PREFIX/Library
