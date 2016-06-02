#!/bin/bash

./configure --prefix=$PREFIX --with-zlib=$PREFIX \
    --with-bzip2=$PREFIX --with-png=$PREFIX --without-harfbuzz
make
make install
