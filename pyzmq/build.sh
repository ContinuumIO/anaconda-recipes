#!/bin/bash

if [ `uname` == Darwin ]
then
    export LDFLAGS="-headerpad_max_install_names $LDFLAGS"
    ZMQ=bundled
else
    export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
    ZMQ=$PREFIX
fi

$PYTHON setup.py configure --zmq=$ZMQ
$PYTHON setup.py install
