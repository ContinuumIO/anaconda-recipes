#!/bin/bash

export C_INCLUDE_PATH="$PREFIX/include"
export LIBRARY_PATH="$PREFIX/lib"

# NO_TCLTK disables git-gui
# NO_GETTEXT disables internationalization (localized message translations)
# NO_INSTALL_HARDLINKS uses symlinks which makes the package 85MB slimmer (8MB instead of 93MB!)
make \
    --jobs="$CPU_COUNT" \
    prefix="$PREFIX" \
    NO_TCLTK=1 \
    NO_GETTEXT=1 \
    NO_INSTALL_HARDLINKS=1 \
    all strip install

curl https://raw.githubusercontent.com/bagder/ca-bundle/master/ca-bundle.crt -o $PREFIX/bin/ca-bundle.crt

mkdir -p $PREFIX/etc
cat > $PREFIX/etc/gitconfig <<endmsg
[http]
    sslVerify = true
    sslCAinfo = $PREFIX/bin/ca-bundle.crt
endmsg
