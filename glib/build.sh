#!/bin/bash

declare -a _extra_config

if [[ $(uname) == Darwin ]]; then
  _extra_config+=(--with-libiconv=yes)
  export LDFLAGS=$LDFLAGS" -L${PREFIX}/lib"
  export CFLAGS=$CFLAGS" -I${PREFIX}/include"
  export DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib
fi

LIBFFI_CFLAGS="-I$PREFIX/include" \
LIBFFI_LIBS="-L$PREFIX/lib -lffi" \
  ./configure --prefix="$PREFIX" --disable-libmount "${_extra_config[@]}"
make
make install

cd $PREFIX
sed -i.bak 's|lib/../lib64|lib|g' lib/*.la lib/pkgconfig/*.pc
rm lib/*.la.bak lib/pkgconfig/*.pc.bak

# contains .py files which cause trouble
rm -rf share/glib-2.0

rm -rf share/gdb/auto-load/*
rm -rf share/gtk-doc
