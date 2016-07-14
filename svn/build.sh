#!/bin/bash

./configure --prefix=$PREFIX --with-sqlite=$PREFIX \
            --with-zlib=$PREFIX --with-openssl=$PREFIX \
            --with-serf=$PREFIX
make
make install
