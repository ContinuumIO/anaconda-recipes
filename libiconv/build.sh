#!/bin/sh


export CFLAGS="-fPIC $CFLAGS"

./configure --prefix=${PREFIX} \
            --enable-static \
            --disable-rpath

make
make check
make install

if [[ $(uname) == Linux ]]; then
  chmod 755 $PREFIX/lib/libiconv.so.2.5.1
  chmod 755 $PREFIX/lib/libcharset.so.1.0.0
  chmod 755 $PREFIX/lib/preloadable_libiconv.so
fi
