#!/bin/bash

./configure --enable-shared --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share
rm -rf $PREFIX/sbin
