#!/bin/bash

rm -rf Lib/test Lib/*/test

UCS=4
REPLACE=replace
OSX_ARCH=64

if [ `uname` == Darwin ]; then
    ./configure --enable-shared --enable-ipv6 --enable-unicode=ucs$UCS $DOPT \
        --prefix=$PREFIX \
        CFLAGS="-I$PREFIX/include $CFLAGS" \
        LDFLAGS="-L$PREFIX/lib $LDFLAGS"
fi
if [ `uname` == Linux ]; then
    ./configure --enable-shared --enable-ipv6 --enable-unicode=ucs$UCS $DOPT \
        --prefix=$PREFIX \
        --with-tcltk-includes="-I$PREFIX/include" \
        --with-tcltk-libs="-L$PREFIX/lib -ltcl8.5 -ltk8.5" \
        CPPFLAGS="-I$PREFIX/include" \
        LDFLAGS="-L$PREFIX/lib -Wl,-rpath=$PREFIX/lib,--no-as-needed"
fi

make
make install

if [ `uname` == Darwin ]; then
    DYNLOAD_DIR=$STDLIB_DIR/lib-dynload
    if [ $ARCH == 64 ]; then
        #rm $DYNLOAD_DIR/_hashlib_failed.so
        #rm $DYNLOAD_DIR/_ssl_failed.so
        #rm $DYNLOAD_DIR/_tkinter_failed.so
        pushd Modules
        rm -rf build
        cp $RECIPE_DIR/setup_osx.py .
        $PYTHON setup_osx.py build
        cp build/lib.macosx-*/_hashlib.so \
           build/lib.macosx-*/_ssl.so \
           build/lib.macosx-*/_tkinter.so \
               $DYNLOAD_DIR
        popd
    fi
    pushd $DYNLOAD_DIR
    mv readline_failed.so readline.so
    popd
    #$REPLACE gcc-4.2 gcc \
    #    $STDLIB_DIR/_sysconfigdata.py \
    #    $STDLIB_DIR/config/Makefile
    #$REPLACE g++-4.2 g++ \
    #    $STDLIB_DIR/_sysconfigdata.py \
    #    $STDLIB_DIR/config/Makefile
fi
if [ `uname` == Linux ]; then
    pushd $PREFIX/bin
    rm python2-config python-config
    mv python2.7-config python-config
    popd
    if [ $CC != "gcc" ]; then
	$REPLACE $CC gcc \
            $STDLIB_DIR/_sysconfigdata.py \
            $STDLIB_DIR/config/Makefile
	$REPLACE $CXX g++ \
            $STDLIB_DIR/_sysconfigdata.py \
            $STDLIB_DIR/config/Makefile
    fi
fi
