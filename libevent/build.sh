#!/bin/bash

./configure --prefix=$PREFIX
make
make install

rm -f $PREFIX/bin/*.py
