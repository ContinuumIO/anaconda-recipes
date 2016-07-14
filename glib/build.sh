#!/bin/bash

if [ $ARCH == 32 ]; then
    export "CFLAGS=$CFLAGS -march=i486"
    export "CXXFLAGS=$CXXFLAGS -march=i486"
fi

export LIBFFI_CFLAGS="-L$PREFIX/lib -I$PREFIX/include"
export LIBFFI_LIBS="-lffi"

./configure --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share/gtk-doc
rm -f $PREFIX/share/glib-2.0/codegen/*.py[co]
