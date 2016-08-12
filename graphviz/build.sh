#!/bin/bash

if [ `uname` == Darwin ]; then
    ./configure --prefix=$PREFIX \
                --with-quartz \
                --disable-debug \
                --disable-java \
                --disable-php \
                --disable-perl \
                --disable-tcl \
                --without-x \
                --without-qt \
                --without-gtk
else
    ./configure --prefix=$PREFIX \
                --disable-debug \
                --disable-java \
                --disable-php \
                --disable-perl \
                --disable-tcl \
                --without-x \
                --without-qt \
                --without-gtk
fi

if [[ (`uname` == Linux) && (`uname -m` == 'x86_64') ]]; then
    pushd $PREFIX
    ln -s lib lib64
    popd
fi

make
# This is failing for rtest.
# Doesn't do anything for the rest
# make check
make install

dot -c

rm -f $PREFIX/lib64
