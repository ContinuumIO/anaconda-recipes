#!/bin/bash

export CFLAGS="-I${PREFIX}/include"

if [[ (`uname` == Darwin) ]]; then
    export CC='gcc -arch x86_64'
    export DYLD_LIBRARY_PATH="$PREFIX/lib"
fi

$PYTHON setup.py install --old-and-unmanageable

rm $PREFIX/bin/easy_install-*
