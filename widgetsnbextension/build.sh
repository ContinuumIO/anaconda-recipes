#!/bin/bash

$PYTHON setup.py install --single-version-externally-managed --record=record.txt

jupyter-nbextension install widgetsnbextension --py --sys-prefix --overwrite
