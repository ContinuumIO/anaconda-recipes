#!/bin/bash

rm setup.cfg
rm webapp/content/js/ext/adapter/.DS_Store

$PYTHON setup.py install
