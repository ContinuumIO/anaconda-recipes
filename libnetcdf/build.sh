#!/bin/bash

export CFLAGS="-I$PREFIX/include $CFLAGS"
export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
export DYLD_LIBRARY_PATH=$PREFIX/lib

./configure \
    --enable-shared \
    --enable-netcdf-4 \
    --enable-hdf4 \
    --enable-hdf5 \
    --enable-dap \
    --without-ssl \
    --without-libidn \
    --disable-ldap \
    --disable-doxygen \
    --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share
