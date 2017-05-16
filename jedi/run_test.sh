#!/bin/bash

if ! find $(${PYTHON} -c "import sysconfig; print(sysconfig.get_path('stdlib'))") -name "grammar*.txt"; then
  echo "Did not find any grammar*.txt files"
  exit 1
fi
