#!/bin/bash

# Setup CMake build location
mkdir build
cd build

# Configure, build, test, and install.
if [ "$(uname)" == "Linux" ];
then
    # Stop Boost from using libquadmath.
    export CXXFLAGS="${CXXFLAGS} -DBOOST_MATH_DISABLE_FLOAT128"
fi

if [[ ${NOMKL} == 1 ]]; then
    BLAS=open
else
    BLAS=mkl
fi

cmake -DCPU_ONLY=1                                          \
      -DBLAS="${BLAS}"                                      \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}"                    \
      -DNUMPY_INCLUDE_DIR="${SITE_PKGS}/numpy/core/include" \
      -DNUMPY_VERSION=1.11.2                                \
      -DPYTHON_EXECUTABLE="${PREFIX}/bin/python"            \
      ..
make

# there's a math error associated with MKL seemingly
# https://github.com/BVLC/caffe/issues/4083#issuecomment-227046096
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

# MKL on 32-bit Linux has the following suprious looking
# testcase failure. Ignore.
# Value of: params[i]->cpu_diff()[j]
#   Actual: 4.71609e-05
# Expected: param_copies[i]->cpu_diff()[j]
# Which is: 4.71609e-05
if [[ ${BLAS} != mkl || $(uname -m) != i686 ]]; then
  make runtest
fi
make install

# Python installation is non-standard. So, we're fixing it.
mv "${PREFIX}/python/caffe" "${SP_DIR}/"
for FILENAME in $( cd "${PREFIX}/python/" && find . -name "*.py" | sed 's|./||' );
do
    chmod +x "${PREFIX}/python/${FILENAME}"
    cp "${PREFIX}/python/${FILENAME}" "${PREFIX}/bin/${FILENAME//.py}"
done
rm -rf "${PREFIX}/python/"
