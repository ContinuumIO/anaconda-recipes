#!/bin/bash

if [ $PY_VER != 3.4 ]; then
    echo "PY_VER: $PY_VER"
    echo "Please use conda-build with --python=3.4 option"
    exit 1
fi

rm -rf Lib/test Lib/*/test
rm -rf Lib/ensurepip

if [ `uname` == Darwin ]; then
    export CFLAGS="-I$PREFIX/include $CFLAGS"
    export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
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

pushd $PREFIX/bin
ln -s python3.4 python
ln -s pydoc3.4 pydoc
popd

export PYTHON=$PYTHON_BAK

DYNLOAD_DIR=$PREFIX/lib/python3.4/lib-dynload
if [ `uname` == Darwin ]; then
    rm $DYNLOAD_DIR/_hashlib_failed.so
    rm $DYNLOAD_DIR/_ssl_failed.so
    pushd Modules
    rm -rf build
    cp $RECIPE_DIR/setup_misc.py .
    $PYTHON setup_misc.py build
    cp build/lib.macosx-*/_hashlib.so \
       build/lib.macosx-*/_ssl.so \
           $DYNLOAD_DIR
    popd
    pushd $DYNLOAD_DIR
    mv readline_failed.so readline.so
    mv _lzma_failed.so _lzma.so
    popd
fi

replace '-Werror=declaration-after-statement' '' \
    $PREFIX/lib/python3.4/_sysconfigdata.py \
    $PREFIX/lib/python3.4/config-3.4m/Makefile

if [ `uname -m` == ppc64le ]; then
    cp $HOME/py34/readline.so $DYNLOAD_DIR/
fi
