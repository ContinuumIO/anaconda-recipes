#!/bin/bash

STATIC=$SP_DIR/IPython/html/static

mkdir -p $STATIC

mv $SRC_DIR $STATIC/mathjax
