import os
import sys
import numpy

assert numpy.__version__ == '1.12.1'

has_mkl = not int(os.getenv('NOMKL', 0))
print('HAS MKL: %r' % has_mkl)
mkl_version = getattr(numpy, '__mkl_version__', None)
print('MKL VERSION: %s' % mkl_version)
assert has_mkl == bool(mkl_version)

import numpy.core.multiarray
import numpy.core.multiarray_tests
import numpy.core.numeric
import numpy.core.operand_flag_tests
import numpy.core.struct_ufunc_test
import numpy.core.test_rational
import numpy.core.umath
import numpy.core.umath_tests
import numpy.fft.fftpack_lite
import numpy.linalg._umath_linalg
import numpy.linalg.lapack_lite
import numpy.random.mtrand

from cio_bt.mkl_link import test_modules
test_modules([numpy.linalg.lapack_lite])

from numpy.fft import using_mklfft

if sys.platform == 'win32' and sys.version_info[0] == 3:
    print('Not running numpy tests Windows on Py3k')
else:
    numpy.test()

print('USING MKLFFT: %s' % using_mklfft)
