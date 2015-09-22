#!/bin/bash

#if [ `uname` == Linux ]; then
#    CC=gcc44
#    CXX=g++44
#fi
#if [ `uname` == Darwin ]; then
#    # unlike most other packages, we build opencv on OSX 10.7
#    CC=gcc
#    CXX=g++
#    unset CFLAGS LDFLAGS CXXFLAGS SDK
#    unset MACOSX_DEPLOYMENT_TARGET
#    env | sort
#    #EXTRA="-DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk/"
#fi

#if [ $PY3K == '1' ]; then
#    PYTHON_SUPPORT="-DBUILD_opencv_python3=ON"
#else
#    PYTHON_SUPPORT="-DBUILD_opencv_python2=ON"
#fi

mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE \
-DCMAKE_INSTALL_PREFIX=$PREFIX \
-DBUILD_SHARED_LIBS=ON \
-DJPEG_INCLUDE_DIR:PATH=$PREFIX/include \
-DJPEG_LIBRARY:FILEPATH=$PREFIX/lib/libjpeg.so \
-DPNG_LIBRARY:FILEPATH=$PREFIX/lib/libpng.so \
-DZLIB_LIBRARY:FILEPATH=$PREFIX/lib/libz.so \
-DBUILD_opencv_apps=ON \
-DPYTHON_EXECUTABLE=$PYTHON $SRC_DIR

make
make install

rm -rf $PREFIX/share/OpenCV

