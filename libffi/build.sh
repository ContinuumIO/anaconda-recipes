#!/bin/bash

./configure --prefix=$PREFIX || exit 1
make || exit 1
make install || exit 1

cd $PREFIX
rm -rf share
mv lib/libffi-3.0.13/include include
if [ `uname -m` == x86_64 ]; then
    rm -rf lib
    mv lib64 lib
else
    rm -rf lib/pkgconfig
fi
