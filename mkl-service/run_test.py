import mkl
import mkl.test

for s in ('mkl.get_max_threads()', 'mkl.get_cpu_clocks()', 'mkl.mem_stat()',
          'mkl.get_cpu_frequency()', 'mkl.get_version_string()'):
    print('%s=%r' % (s, eval(s)))

assert mkl.test.run().wasSuccessful()
assert 'Math Kernel Library Version 2017.0.' in mkl.get_version_string()
assert mkl.__version__ == '1.1.2'
