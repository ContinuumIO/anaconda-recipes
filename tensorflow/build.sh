#!/bin/bash

set -ex

# Compile tensorflow from source
export PYTHON_BIN_PATH=${PYTHON}
export PYTHON_LIB_PATH=${SP_DIR}
export CC_OPT_FLAGS="-march=nocona"
# disable jemmloc (needs MADV_HUGEPAGE macro which is not in glib <= 2.12)
export TF_NEED_JEMALLOC=0
export TF_NEED_GCP=0
export TF_NEED_HDFS=0
export TF_ENABLE_XLA=0
export TF_NEED_OPENCL=0
export TF_NEED_CUDA=0
./configure

export CFLAGS="-I${PREFIX}/include -L${PREFIX}/lib $CFLAGS"
export CXXFLAGS="-I${PREFIX}/include -L${PREFIX}/lib $CXXFLAGS"

# build using bazel
bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package

# build a whl file
mkdir $SRC_DIR/tensorflow_pkg
bazel-bin/tensorflow/tools/pip_package/build_pip_package $SRC_DIR/tensorflow_pkg

# install using pip from the whl file
pip install --no-deps $SRC_DIR/tensorflow_pkg/*.whl
