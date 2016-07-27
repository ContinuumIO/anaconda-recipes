#!/bin/bash

echo "NOMKL: $NOMKL"
$PREFIX/bin/mkl-version --check

if [ `uname` == Darwin ]
then
    if [ $NOMKL == 0 ]; then
        export ATLAS=1
    fi
    export LDFLAGS="-headerpad_max_install_names $LDFLAGS"

    FCFLAGS=$CFLAGS
    # link statically against the fortran libraries
    cp /usr/local/lib/libgfortran*.*a .
    LDFLAGS="-undefined dynamic_lookup -bundle -Wl,-search_paths_first -L$(pwd) $LDFLAGS"
fi

$PYTHON setup.py install --old-and-unmanageable
