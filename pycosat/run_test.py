import sys
import pycosat
import test_pycosat

assert test_pycosat.run().wasSuccessful()

if sys.platform != 'win32':
    assert pycosat.__version__ == '0.6.1'

assert test_pycosat.process_cnf_file('qg3-08.cnf') == 18
assert test_pycosat.process_cnf_file('uf20-098.cnf') == 5
