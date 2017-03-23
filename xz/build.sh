#!/bin/bash

head -n 9999 COPYING* > all-licenses.txt

./configure --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share

mkdir $PREFIX/tmp
cd $PREFIX/bin
mv xz unxz $PREFIX/tmp/
rm -f *
mv $PREFIX/tmp/* .
