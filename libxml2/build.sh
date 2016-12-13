#!/bin/bash

if [[ $(uname) == Darwin ]]; then
    EXTRA_ARGS="--without-threads"
fi

# Although lxml is recommended over libxml2, gtk-doc needs the
# libxml2 python module and it has been asked for it on github.
# ./configure ${EXTRA_ARGS} --prefix=${PREFIX} --with-python --with-iconv=${PREFIX} --without-lzma
# Unfortunately, due to hotfixing it is not possible to use the
# Python module. Perhaps split packages could allow it?
./configure \
    ${EXTRA_ARGS} \
    --prefix=${PREFIX} \
    --with-iconv=${PREFIX} \
    --without-lzma
make
make install

rm -rf $PREFIX/share/doc
rm -rf $PREFIX/share/gtk-doc
