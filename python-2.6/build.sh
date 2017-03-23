#!/bin/bash

rm -rf Lib/test Lib/*/test

if [ `uname` == Darwin ]; then
    export CFLAGS="-I$PREFIX/include $CFLAGS"
    export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
    $REPLACE "@OSX_ARCH@" "'$OSX_ARCH'" Lib/distutils/unixccompiler.py
fi

./configure --enable-shared --enable-ipv6 --enable-unicode=ucs$UCS \
    --prefix=$PREFIX
make
make install

if [ `uname` == Darwin ]; then
    DYNLOAD_DIR=$STDLIB_DIR/lib-dynload
    rm $DYNLOAD_DIR/_hashlib_failed.so
    rm $DYNLOAD_DIR/_ssl_failed.so
    rm $DYNLOAD_DIR/_tkinter_failed.so
    pushd Modules
    rm -rf build
    cp $RECIPE_DIR/setup_misc.py .
    $PYTHON setup_misc.py build
    cp build/lib.macosx-*/_hashlib.so \
       build/lib.macosx-*/_ssl.so \
       build/lib.macosx-*/_tkinter.so \
           $DYNLOAD_DIR
    popd
    pushd $DYNLOAD_DIR
    mv readline_failed.so readline.so
    popd

    $REPLACE 'gcc-4.2' 'gcc' $PREFIX/lib/python2.6/config/Makefile
fi
if [ `uname` == Linux ]; then
    $REPLACE gcc44 gcc \
        $STDLIB_DIR/config/Makefile
fi
