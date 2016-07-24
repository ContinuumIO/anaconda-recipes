#!/bin/bash

ln -s $PREFIX/lib $PREFIX/lib64

bash configure --prefix=$PREFIX --with-xft
make
make install

rm -rf $PREFIX/share/gtk-doc
rm $PREFIX/lib64
