#!/bin/bash

cd Modules
cp $RECIPE_DIR/setup.py .
$PYTHON setup.py install

cd $PREFIX/lib/python${PY_VER}
mv site-packages/_bsddb.so lib-dynload/
rm -rf ${SP_DIR}
