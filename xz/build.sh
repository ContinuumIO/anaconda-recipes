#!/bin/bash

./configure --prefix=$PREFIX
make
make install

rm -rf $PREFIX/bin
rm -rf $PREFIX/share
