#!/bin/bash

if [ $NOMKL == 1 ]
then # Non-MKL
    if [ `uname` == Linux ]; then
        SITE_CFG="site-openblas-linux.cfg"
    else
        SITE_CFG="site-empty.cfg"
    fi
else # MKL
    $PREFIX/bin/mkl-version numpy/__init__.py
    if [ `uname` == Darwin ]; then
        export ATLAS=1
        export LDFLAGS="-headerpad_max_install_names $LDFLAGS"
    fi
    SITE_CFG="site-mkl-$SUBDIR.cfg"
fi

sed -e "s,@PREFIX@,$PREFIX," <$PREFIX/cio_files/numpy/$SITE_CFG >site.cfg

if [ ! -f site.cfg ]; then
    echo "ERROR: *** site.cfg missing ***"
    exit 1
fi

$PYTHON setup.py config
$PYTHON setup.py build --fcompiler=gfortran
$PYTHON setup.py install --old-and-unmanageable
