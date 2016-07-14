#!/bin/bash

ln -s $PREFIX/lib $PREFIX/lib64

bash configure --prefix=$PREFIX --with-xft
make
make install
