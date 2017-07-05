#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

./configure $B --prefix=$PREFIX --disable-static \
    --enable-linux-lfs --with-ssl \
    --enable-threadsafe --with-pthread=yes \
    --enable-production --enable-cxx \
    --with-zlib="$PREFIX" \
    --enable-unsupported
make -j${CPU_COUNT}
make install

rm -rf $PREFIX/share/hdf5_examples
