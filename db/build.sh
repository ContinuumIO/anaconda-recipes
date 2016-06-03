#!/bin/bash

cd build_unix
../dist/configure --prefix=$PREFIX
make
make install

cd $PREFIX
rm -rf docs
