#!/bin/bash

./configure \
    --sysconfdir=/etc \
    --prefix=$PREFIX
make
make install
