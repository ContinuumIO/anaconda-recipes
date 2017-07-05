#!/bin/bash

mkdir build && cd build

cmake .. \
      -DBUILD_SHARED_LIBS=ON \
      -DCRYPTO_BACKEND=OpenSSL \
      -DENABLE_DEBUG_LOGGING=ON \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DENABLE_ZLIB_COMPRESSION=ON \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_RPATH=$PREFIX/lib ..

cmake --build . --config Release --target install

cmake .. \
      -DBUILD_SHARED_LIBS=OFF \
      -DCRYPTO_BACKEND=OpenSSL \
      -DENABLE_DEBUG_LOGGING=ON \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DENABLE_ZLIB_COMPRESSION=ON \
      -DCMAKE_INSTALL_PREFIX=$PREFIX

cmake --build . --config Release --target install
