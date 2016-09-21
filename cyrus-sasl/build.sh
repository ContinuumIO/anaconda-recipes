#!/bin/bash

pushd ${SRC_DIR}
./configure --prefix=${PREFIX} --with-des=no
make
make install
popd




