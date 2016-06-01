#!/bin/bash

echo "NOMKL: $NOMKL"
if [ $NOMKL == 0 ]; then
    sed -e "s,@PREFIX@,$PREFIX," <$RECIPE_DIR/site-mkl-$SUBDIR.cfg >site.cfg
fi

$PYTHON setup.py install
