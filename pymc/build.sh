#!/bin/bash

if [ `uname` == Darwin ]; then
    FCFLAGS=$CFLAGS
    # link statically against the fortran libraries
    cp /usr/local/lib/libgfortran*.*a .
    LDFLAGS="-undefined dynamic_lookup -bundle -Wl,-search_paths_first -L$(pwd) -headerpad_max_install_names $LDFLAGS"
fi

$PYTHON setup.py install
