#!/bin/bash

if [ $PY_VER != 3.5 ]; then
    echo "PY_VER: $PY_VER"
    echo "Please use conda-build with --python=3.5 option"
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
    # see https://bugs.python.org/issue24844
    replace \
        '#define HAVE_BUILTIN_ATOMIC 1' \
        '/* #define HAVE_BUILTIN_ATOMIC 1 */' \
        pyconfig.h
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
ln -s python3.5 python
ln -s pydoc3.5 pydoc
popd

export PYTHON=$PYTHON_BAK

DYNLOAD_DIR=$PREFIX/lib/python3.5/lib-dynload
if [ `uname` == Darwin ]; then
    rm $DYNLOAD_DIR/_hashlib.cpython-35m-darwin_failed.so
    rm $DYNLOAD_DIR/_ssl.cpython-35m-darwin_failed.so
    pushd Modules
    rm -rf build
    cp $RECIPE_DIR/setup_misc.py .
    $PYTHON setup_misc.py build
    cp build/lib.macosx-*/_hashlib.cpython-35m-darwin.so \
       build/lib.macosx-*/_ssl.cpython-35m-darwin.so \
           $DYNLOAD_DIR
    popd
    pushd $DYNLOAD_DIR
    mv readline.cpython-35m-darwin_failed.so readline.cpython-35m-darwin.so
    mv _lzma.cpython-35m-darwin_failed.so _lzma.cpython-35m-darwin.so
    popd
fi

if [ `uname -m` == ppc64le ]; then
    cp $HOME/py35/readline.so $DYNLOAD_DIR/
fi
