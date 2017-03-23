#!/bin/bash

cd python
export HS2CLIENT_HOME=$PREFIX
$PYTHON setup.py install --old-and-unmanageable
