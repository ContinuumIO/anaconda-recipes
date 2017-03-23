#!/bin/sh

test -f $PREFIX/etc/conda/activate.d/java_home.sh
test -f $PREFIX/etc/conda/deactivate.d/java_home.sh
if [ "$JAVA_HOME" != "$PREFIX" ]; then exit 1; fi
