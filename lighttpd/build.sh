#!/bin/bash

./configure \
    --without-bzip2 \
    --without-pcre \
    --with-sysroot=$PREFIX \
    --prefix=$PREFIX
make
make install

rm -rf $PREFIX/bin
mv $PREFIX/sbin $PREFIX/bin
