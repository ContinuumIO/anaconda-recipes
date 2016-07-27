#!/bin/bash

mv setup.py setup.org
cat $RECIPE_DIR/mkl_conf.py setup.org >setup.py

if [ `uname` == Linux ]
then
    export LDFLAGS="$LDFLAGS -Wl,--no-as-needed -lrt"
fi

$PYTHON setup.py install
