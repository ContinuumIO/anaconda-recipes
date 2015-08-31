#!/bin/bash

cd unix 
./configure --prefix=$PREFIX make make install
cd $PREFIX
rm -rf man share
