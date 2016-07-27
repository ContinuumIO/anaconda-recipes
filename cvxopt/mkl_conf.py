import os
import sys


assert os.getenv('NOMKL') == '0'


if tuple.__itemsize__ == 8: # 64-bit
    COMMON = ['mkl_core', 'mkl_intel_lp64', 'mkl_intel_thread']
elif tuple.__itemsize__ == 4: # 32-bit
    COMMON = ['mkl_core', 'mkl_intel', 'mkl_intel_thread']

if sys.platform == 'win32':
    COMMON = [s + '_dll' for s in COMMON]
    BLAS_LIB_DIR = os.path.join(sys.prefix, 'Library', 'lib')
else:
    COMMON.append('iomp5')
    BLAS_LIB_DIR = os.path.join(sys.prefix, 'lib')

if tuple.__itemsize__ == 8: # 64-bit
    BLAS_LIB = ['mkl_blas95_lp64'] + COMMON
    LAPACK_LIB = ['mkl_lapack95_lp64']
elif tuple.__itemsize__ == 4: # 32-bit
    BLAS_LIB = ['mkl_blas95'] + COMMON
    LAPACK_LIB = ['mkl_lapack95']

BLAS_EXTRA_LINK_ARGS = []
