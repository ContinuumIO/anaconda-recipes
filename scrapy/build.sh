#!/bin/bash

$PYTHON setup.py install --single-version-externally-managed --root=/

rm -rf $SP_DIR/cryptography-*
