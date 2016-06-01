import os
import numpy
import numexpr
import numexpr.interpreter
from multiprocessing import freeze_support

from cio_bt.mkl_link import test_modules
test_modules([numexpr.interpreter])

has_mkl = not int(os.getenv('NOMKL', 0))
print('MKL: %r' % has_mkl)

use_vml = getattr(numexpr, 'use_vml', None)
print('numexpr.use_vml: %r' % use_vml)

assert use_vml == has_mkl == bool(getattr(numpy, '__mkl_version__', None))

if has_mkl:
    vml_version = numexpr.get_vml_version()
    print("VML: %r" % vml_version)
    vmls = 'Intel(R) Math Kernel Library Version '
    assert vml_version.startswith(vmls)


def run_tests():
    numexpr.test()


if __name__ == "__main__":
    freeze_support()
    run_tests()
