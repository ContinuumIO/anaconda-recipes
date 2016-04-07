#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

KRB5_SRC=$SRC_DIR/src

cd $KRB5_SRC

./configure $B --prefix=$PREFIX
make
make install

cd $PREFIX
rm -rf share
