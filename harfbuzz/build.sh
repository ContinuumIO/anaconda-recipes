#!/bin/bash

bash configure --prefix=$PREFIX
make
make install

cp src/hb-ft.h $PREFIX/include
cp src/hb-glib.h $PREFIX/include
