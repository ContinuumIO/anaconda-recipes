#!/bin/bash

if [[ (`uname` == Darwin) && ($NOMKL == 0) ]]; then
    export ATLAS=1
    export LDFLAGS="-headerpad_max_install_names $LDFLAGS"
fi

$PYTHON setup.py install

rm -rf $SP_DIR/scikits
