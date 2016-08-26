#!/bin/bash

export PORTAUDIO_PATH=$PREFIX
$PYTHON setup.py install --static-link
