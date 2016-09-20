#!/bin/bash

curl -O ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz
tar -xvzf cyrus-sasl-2.1.26.tar.gz
pushd cyrus-sasl-2.1.26
./configure --prefix=$PREFIX --with-des=no
make
make install
popd

$PYTHON setup.py build_ext --include-dirs=${PREFIX}/include --library-dirs=${PREFIX}/lib
$PYTHON setup.py install --single-version-externally-managed --record=record.txt

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
