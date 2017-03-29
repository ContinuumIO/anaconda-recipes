#!/bin/bash

if [ `uname -m` == 'ppc64le' ]; then
    echo "============= ERROR ======== recipe not for POWER8 ================="
    exit 1
fi

./configure --prefix=$PREFIX --with-curses
make
make install

rm -rf $PREFIX/share/man
rm -rf $PREFIX/share/readline
