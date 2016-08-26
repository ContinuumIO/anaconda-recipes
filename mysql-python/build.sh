#!/bin/bash

rm $PREFIX/lib/libmysqlclient*.so*
$REPLACE 'static = False' 'static = True' site.cfg

$PYTHON setup.py install --single-version-externally-managed --root=/
