#!/bin/bash

if [ `uname` == Darwin ]; then
    export LDFLAGS="-headerpad_max_install_names $LDFLAGS"
fi

$PYTHON setup.py install --single-version-externally-managed --root=/

rm -f $SP_DIR/__pycache__/pkg_res*
