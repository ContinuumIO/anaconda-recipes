#!/bin/bash

$PYTHON setup.py install

# ipywidgets
jupyter-nbextension enable widgetsnbextension --py --sys-prefix
