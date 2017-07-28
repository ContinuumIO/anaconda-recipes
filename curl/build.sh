#!/bin/bash

export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig"
export C_INCLUDE_PATH="${PREFIX}/include"

if [[ `uname` == "Darwin" ]]
then
    export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib"
    export CC=clang
    export CXX=clang++
fi

./configure \
    --disable-ldap \
    --prefix=${PREFIX} \
    --with-ca-bundle=${PREFIX}/ssl/cacert.pem \
    --with-ssl=${PREFIX} \
    --with-zlib=${PREFIX} \
    --with-gssapi=${PREFIX} \
    --with-libssh2=${PREFIX}

make
make install

rm -rf $PREFIX/share
