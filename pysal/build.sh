#!/bin/bash

rm -f pysal/examples/snow_maps/*~

$PYTHON setup.py install --old-and-unmanageable
