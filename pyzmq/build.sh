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

if [ $PY_VER == 2.7 ]; then
    rm $SP_DIR/zmq/asyncio.py
    rm $SP_DIR/zmq/auth/asyncio.py
    rm $SP_DIR/zmq/tests/_test_asyncio.py
fi
