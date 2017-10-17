#!/bin/bash

./configure --enable-shared --prefix=$PREFIX "F77=$FC" "FCFLAGS=$FFLAGS"
make
make install

rm -rf $PREFIX/share
rm -rf $PREFIX/sbin
