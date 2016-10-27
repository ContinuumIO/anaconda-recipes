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


def issue53():
    import numexpr, numpy as np
    from numexpr import NumExpr, E
    func = NumExpr((E.a + 2.0 * E.b) / (1 + E.a + 4 * E.b * E.b))
    a = np.arange(10.0)
    b = np.arange(10.0)*0.2
    x = (a + 2 * b) / (1 + a + 4 * b * b)
    y = func(a, b)


if __name__ == "__main__":
    freeze_support()
    run_tests()
    issue53()
