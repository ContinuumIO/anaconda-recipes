#!/bin/bash

mv setup.py setup.org
cat $RECIPE_DIR/mkl_conf.py setup.org >setup.py

if [ `uname` == Linux ]
then
    export LDFLAGS="$LDFLAGS -Wl,--no-as-needed -lrt"
fi
if [ `uname` == Darwin ]; then
    export LDFLAGS="-headerpad_max_install_names $LDFLAGS"
fi

$PYTHON setup.py install
