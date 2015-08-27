#!/bin/bash

#rm -rf Lib/test Lib/*/test

REPLACE=replace

if [ `uname` == Darwin ]; then
    export CFLAGS="-I$PREFIX/include $CFLAGS"
    export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
    $REPLACE "@OSX_ARCH@" "'$ARCH'" Lib/distutils/unixccompiler.py
fi

PYTHON_BAK=$PYTHON
unset PYTHON

if [ `uname` == Darwin ]; then
    ./configure --enable-shared --enable-ipv6 --with-ensurepip=no \
        --prefix=$PREFIX
fi
if [ `uname` == Linux ]; then
    ./configure --enable-shared --enable-ipv6 --with-ensurepip=no \
        --prefix=$PREFIX \
        --with-tcltk-includes="-I$PREFIX/include" \
        --with-tcltk-libs="-L$PREFIX/lib -ltcl8.5 -ltk8.5" \
        CPPFLAGS="-I$PREFIX/include" \
        LDFLAGS="-L$PREFIX/lib -Wl,-rpath=$PREFIX/lib,--no-as-needed"
fi

make
make install
export PYTHON=$PYTHON_BAK

if [ `uname` == Darwin ]; then
    DYNLOAD_DIR=$STDLIB_DIR/lib-dynload
    #rm $DYNLOAD_DIR/_hashlib_failed.so
    #rm $DYNLOAD_DIR/_ssl_failed.so
    #rm $DYNLOAD_DIR/_sqlite3_failed.so
    #if [ $ARCH == 64 ]; then
    #    rm $DYNLOAD_DIR/_tkinter_failed.so
    #fi
    pushd Modules
    rm -rf build
    cp $RECIPE_DIR/setup_misc.py .
    echo $PYTHON
    $PYTHON setup_misc.py build
    cp build/lib.macosx-*/_hashlib.so \
       build/lib.macosx-*/_ssl.so \
       build/lib.macosx-*/_sqlite3.so \
       build/lib.macosx-*/_tkinter.so \
           $DYNLOAD_DIR
    popd
    pushd $DYNLOAD_DIR
    mv readline_failed.so readline.so
    mv _lzma_failed.so _lzma.so
    popd
fi

if [ $CC != "gcc" ]; then
    $REPLACE $CC gcc $STDLIB_DIR/_sysconfigdata.py \
        $STDLIB_DIR/config-3.4m/Makefile
    $REPLACE $CXX g++ $STDLIB_DIR/_sysconfigdata.py \
        $STDLIB_DIR/config-3.4m/Makefile
fi

$REPLACE '-Werror=declaration-after-statement' '' \
    $PREFIX/lib/python3.4/_sysconfigdata.py \
    $PREFIX/lib/python3.4/config-3.4m/Makefile

cd $PREFIX/bin
ln -s python3.4 python
ln -s pydoc3.4 pydoc
