#!/bin/bash

if [[ (`uname` == Linux) && (`uname -m` != ppc64le) ]]
then
    pushd $PREFIX/lib
    ln -s libtcl8.5.so libtcl.so
    ln -s libtk8.5.so libtk.so
    popd
fi

cp setup.cfg.template setup.cfg

$SYS_PREFIX/bin/replace "/usr/local" "$PREFIX" setupext.py

$PYTHON setup.py install --old-and-unmanageable

rm -f $SP_DIR/*.pth
rm -rf $SP_DIR/PyQt5
rm -rf $SP_DIR/__pycache__
rm -rf $PREFIX/bin/nose*
