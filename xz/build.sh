#!/bin/bash

./configure --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share

mkdir $PREFIX/tmp
cd $PREFIX/bin
mv xz unxz $PREFIX/tmp/
rm -f *
mv $PREFIX/tmp/* .
