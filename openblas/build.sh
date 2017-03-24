#!/bin/bash

if [ `uname -m` == 'armv7l' ]; then
    export TARGET=ARMV7
elif [ `uname -m` == 'ppc64le' ]; then
    export TARGET=POWER8
else
    export TARGET=NEHALEM
fi

make USE_THREAD=1 NUM_THREADS=128 NO_STATIC=1 FC=gfortran TARGET=$TARGET
make install

if [ `uname` == Darwin ]
then
    install_name_tool \
	-change /usr/local/lib/libgfortran.2.dylib @rpath/libgfortran.2.dylib \
	$PREFIX/lib/libopenblas.dylib
fi
