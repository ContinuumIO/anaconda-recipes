#!/bin/bash

if [ `uname` == Darwin ]; then
    ./Configure darwin64-x86_64-cc shared enable-ssl2 --prefix=$PREFIX
else
    ./config shared enable-ssl2 --prefix=$PREFIX
fi

make
make install

cd $PREFIX/ssl
cp $RECIPE_DIR/cacert.pem .
ln -s cacert.pem cert.pem
rm -rf man
