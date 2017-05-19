#!/bin/bash

LIB=$PREFIX/lib
mkdir $LIB
cd $LIB

if [ `uname` == "Linux" ]
then
    if [ $ARCH == '64' ]; then
	cp /usr/local/lib64/libgfortran.so.3.0.0 .
	ln -s libgfortran.so.3.0.0 libgfortran.so.3
    elif [ $ARCH == '32' ]; then
	cp /usr/local/lib/libgfortran.so.3.0.0 .
	ln -s libgfortran.so.3.0.0 libgfortran.so.3
    fi

    if [ `uname -m` == 'ppc64le' ]; then
	cp /usr/lib/powerpc64le-linux-gnu/libgfortran.so.3.0.0 .
	ln -s libgfortran.so.3.0.0 libgfortran.so.3
    fi

    if [ `uname -m` == 'armv7l' ]; then
        cp /usr/lib/arm-linux-gnueabihf/libgfortran.so.3.0.0 .
        ln -s libgfortran.so.3.0.0 libgfortran.so.3
    fi

fi

if [ `uname` == "Darwin" ]
then
    lipo -thin $OSX_ARCH -output $LIB/libgfortran.2.dylib \
	/usr/local/lib/libgfortran.2.dylib
    install_name_tool \
	-id @rpath/libgfortran.2.dylib \
	$LIB/libgfortran.2.dylib
fi
