#!/bin/sh

./configure --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share
