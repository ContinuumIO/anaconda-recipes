#!/bin/sh

scons APR=$PREFIX APU=$PREFIX OPENSSL=$PREFIX PREFIX=$PREFIX
scons install
