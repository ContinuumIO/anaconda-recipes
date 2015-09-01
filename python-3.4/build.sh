#!/bin/bash

REPLACE=replace

if [ `uname` == Darwin ]; then
    export CFLAGS="-I$PREFIX/include $CFLAGS"
    export LDFLAGS="-L$PREFIX/lib -headerpad_max_install_names $LDFLAGS"
    $REPLACE "@OSX_ARCH@" "$ARCH" Lib/distutils/unixccompiler.py
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

#### PGO configuration
EXCLUDE_TESTS="test_gdb test_subprocess test_faulthandler \
    test_multiprocessing test_multiprocessing_fork \
    test_multiprocessing_forkserver test_multiprocessing_spawn \
    test_multiprocessing_main_handling test_signal \
    test_concurrent_futures"
PROFILE_TASK="-m test.regrtest -w -uall,-audio -x $EXCLUDE_TESTS"

make build_all_generate_profile
make run_profile_task PROFILE_TASK="$PROFILE_TASK" || true
make clean
make build_all_use_profile


#make
make install
ln -s $PREFIX/bin/python3.4 $PREFIX/bin/python
ln -s $PREFIX/bin/pydoc3.4 $PREFIX/bin/pydoc
export PYTHON=$PYTHON_BAK

if [ `uname` == Darwin ]; then
    DYNLOAD_DIR=$STDLIB_DIR/lib-dynload
    pushd Modules
    rm -rf build
    cp $RECIPE_DIR/setup_misc.py .
    $PYTHON setup_misc.py build
    cp $SRC_DIR/Modules/build/lib.macosx-*/_hashlib.so \
       $SRC_DIR/Modules/build/lib.macosx-*/_ssl.so \
       $SRC_DIR/Modules/build/lib.macosx-*/_sqlite3.so \
       $SRC_DIR/Modules/build/lib.macosx-*/_tkinter.so \
           $DYNLOAD_DIR
    popd
    pushd $DYNLOAD_DIR
    mv readline_failed.so readline.so
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

