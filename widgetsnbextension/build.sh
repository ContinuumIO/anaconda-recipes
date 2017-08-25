#!/bin/bash

$PYTHON setup.py install --old-and-unmanageable

jupyter-nbextension install widgetsnbextension --py --sys-prefix --overwrite
