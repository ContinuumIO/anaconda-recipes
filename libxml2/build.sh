#!/bin/bash

if [ `uname` == Darwin ]; then
    export EXTRA_ARGS="--without-threads"
fi

./configure $EXTRA_ARGS --prefix=$PREFIX
make
make install

rm -rf $PREFIX/share/doc
rm -rf $PREFIX/share/gtk-doc
