#!/bin/bash

./configure --prefix=$PREFIX
make
make install

cd $PREFIX
rm -rf share
mv lib/libffi-${PKG_VERSION}/include/* include/

if [ `uname -m` == x86_64 ]
then
    rm -rf lib
    mv lib64 lib
else
    rm -rf lib/pkgconfig
fi
