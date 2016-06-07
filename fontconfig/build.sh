#!/bin/bash

sed -i.orig s:'@PREFIX@':"${PREFIX}":g src/fccfg.c

./configure --prefix $PREFIX --enable-libxml2 -disable-docs
make
make install
