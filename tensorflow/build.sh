#!/bin/bash

set -ex

export PYTHON_BIN_PATH=${PYTHON}
# Disable Google cloud compute
export TF_NEED_GCP=0
# Disable gpu for now
export TF_NEED_CUDA=0
./configure

export CFLAGS="-I${PREFIX}/include -L${PREFIX}/lib $CFLAGS"
export CXXFLAGS="-I${PREFIX}/include -L${PREFIX}/lib $CXXFLAGS"

bazel build -c opt //tensorflow/tools/pip_package:build_pip_package

mkdir _python_build
cd _python_build
ln -s ../bazel-bin/tensorflow/tools/pip_package/build_pip_package.runfiles/org_tensorflow/* .
ln -s ../tensorflow/tools/pip_package/* .
python setup.py install --single-version-externally-managed --record=record.txt
