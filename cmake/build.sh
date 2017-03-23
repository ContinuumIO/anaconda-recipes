#!/bin/bash

LDFLAGS=$LDFLAGS" -Wl,-rpath,$PREFIX/lib" \
  ./bootstrap \
             --verbose \
             --prefix="${PREFIX}" \
             --system-libs \
             --no-qt-gui \
             --no-system-libarchive \
             --no-system-jsoncpp \
             -- \
             -DCMAKE_BUILD_TYPE:STRING=Release \
             -DCMAKE_FIND_ROOT_PATH="${PREFIX}"

make
make install
