#!/bin/bash

./configure --with-libtiff=$PREFIX --prefix=$PREFIX
make
make install
