#!/bin/bash

if [ $PY_VER != 2.7 ]; then
    echo "PY_VER: $PY_VER"
    echo "Please use conda-build with --python=2.7 option"
    exit 1
fi

rm -rf Lib/test Lib/*/test
rm -rf Lib/ensurepip

if [ `uname` == Darwin ]; then
    export CFLAGS="-I$PREFIX/include $CFLAGS"
    export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
fi

if [ $DEBUG == 1 ]; then
    DOPT="--with-pydebug"
fi

#if [ $OPT == 1 ]; then
#    export CFLAGS="-fprofile-generate"
#    export LDFLAGS="-fprofile-generate"
#fi

if [ `uname` == Darwin ]; then
    ./configure --enable-shared --enable-ipv6 --enable-unicode=ucs2 $DOPT \
        --prefix=$PREFIX
fi

if [ `uname` == Linux ]; then
    export CC=gcc
    export CPPFLAGS="-I$PREFIX/include"
    export LDFLAGS="$LDFLAGS -L$PREFIX/lib -Wl,-rpath=$PREFIX/lib,--no-as-needed"
    ./configure --enable-shared --enable-ipv6 --enable-unicode=ucs4 $DOPT \
        --prefix=$PREFIX \
        --with-tcltk-includes="-I$PREFIX/include" \
        --with-tcltk-libs="-L$PREFIX/lib -ltcl8.5 -ltk8.5"
fi

make
#if [ $OPT == 1 ]; then
#    make run_profile_task
#    make clean
#    export CFLAGS="-profile-use -profile-correction"
#    export LDFLAGS="-profile-use -profile-correction"
#    make
#fi
make install

if [ `uname` == Darwin ]; then
    DYNLOAD_DIR=$STDLIB_DIR/lib-dynload
    mv $DYNLOAD_DIR/readline_failed.so $DYNLOAD_DIR/readline.so
    rm $DYNLOAD_DIR/_hashlib_failed.so
    rm $DYNLOAD_DIR/_ssl_failed.so
    pushd Modules
    rm -rf build
    cp $RECIPE_DIR/setup_osx.py .
    $PYTHON setup_osx.py build
    cp build/lib.macosx-*/_hashlib.so \
        build/lib.macosx-*/_ssl.so \
        $DYNLOAD_DIR
    popd
fi

if [ `uname` == Linux ]; then
    pushd $PREFIX/bin
    rm python2-config python-config
    mv python2.7-config python-config
    popd
fi
