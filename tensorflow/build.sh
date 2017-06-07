#!/bin/bash

set -ex

mkdir -p ./bazel_output_base
export BAZEL_OPTS="--batch --output_base=./bazel_output_base"

# Compile tensorflow from source
export PYTHON_BIN_PATH=${PYTHON}
export PYTHON_LIB_PATH=${SP_DIR}
if [ `uname -m`  == ppc64le ]; then
    export CC_OPT_FLAGS=" -mtune=powerpc64le"
else
    export CC_OPT_FLAGS="-march=nocona"
fi
# disable jemmloc (needs MADV_HUGEPAGE macro which is not in glib <= 2.12)
export TF_NEED_JEMALLOC=0
export TF_NEED_GCP=0
export TF_NEED_HDFS=0
export TF_ENABLE_XLA=0
export TF_NEED_OPENCL=0
export TF_NEED_CUDA=0
./configure

# build using bazel
bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package

# run tests (skip tests depending on xla and jit)
XLA_TESTS=$(bazel query --keep_going \
            '//tensorflow/... intersect allpaths(//tensorflow/..., //tensorflow/compiler/tests:xla_device_test)' \
             2>/dev/null | awk '{printf " -%s",$0}' || true)

bazel test \
    --local_test_jobs=4 \
    --flaky_test_attempts=9 \
    -- //tensorflow/... \
    -tensorflow/go/... \
    $XLA_TESTS \
    -tensorflow/compiler/tests:jit_test

# build a whl file
mkdir -p $SRC_DIR/tensorflow_pkg
bazel-bin/tensorflow/tools/pip_package/build_pip_package $SRC_DIR/tensorflow_pkg

# install using pip from the whl file
pip install --no-deps $SRC_DIR/tensorflow_pkg/*.whl
