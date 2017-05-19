#!/bin/bash

cp $RECIPE_DIR/LICENSE.txt $SRC_DIR

LIB=$PREFIX/lib
mkdir -p $LIB

if [ `uname -m` == x86_64 ]; then
    INTEL_ARCH=intel64
else
    INTEL_ARCH=ia32
fi

if [ `uname` == Linux ]
then
    INTEL_DIR=/opt/intel/compilers_and_libraries_2017.1.132/linux
    COMP_LIB_DIR=$INTEL_DIR/compiler/lib/$INTEL_ARCH
    MKL_LIB_DIR=$INTEL_DIR/mkl/lib/$INTEL_ARCH

    cp $COMP_LIB_DIR/libiomp5.so $LIB
    cp $MKL_LIB_DIR/lib*.so $LIB
fi

if [ `uname` == Darwin ]
then
    INTEL_LIB=/opt/intel/lib
    MKL_LIB_DIR=/opt/intel/mkl/lib

    $PREFIX/bin/cp-arch \
        --arch $OSX_ARCH \
        --ignore-wrong-arch \
        $INTEL_LIB/libiomp5.dylib \
        $MKL_LIB_DIR/*.dylib \
        $LIB
fi
