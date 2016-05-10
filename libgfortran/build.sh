#!/bin/bash

LIB=$PREFIX/lib
mkdir $LIB
cd $LIB

if [ $ARCH == '64' ]; then
    cp /usr/local/lib64/libgfortran.so.3.0.0 .
    ln -s libgfortran.so.3.0.0 libgfortran.so.3
elif [ $ARCH == '32' ]; then
    cp /usr/local/lib/libgfortran.so.3.0.0 .
    ln -s libgfortran.so.3.0.0 libgfortran.so.3
fi

if [ `uname -m` == 'armv7l' ]; then
    cp /usr/lib/arm-linux-gnueabihf/libgfortran.so.3.0.0 .
    ln -s libgfortran.so.3.0.0 libgfortran.so.3
fi
