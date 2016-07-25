#!/bin/bash

case `uname -m` in
  'armv7l' )
    TARGET=ARMV7
    ;;
  * )
    TARGET=NEHALEM
    ;;
esac

OPTS="USE_THREAD=1 NUM_THREADS=128 TARGET=$TARGET NO_STATIC=1"

make FC=gfortran $OPTS
make PREFIX=$PREFIX $OPTS install
