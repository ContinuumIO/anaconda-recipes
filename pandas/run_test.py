import pandas._join
import pandas._period
import pandas._sparse
import pandas._testing
import pandas._window
import pandas.algos
import pandas.hashtable
import pandas.index
import pandas.io.sas.saslib
import pandas.json
import pandas.lib
import pandas.msgpack._packer
import pandas.msgpack._unpacker
import pandas.parser
import pandas.tslib
import pandas.util._move

import os
import sys
if sys.version_info >= (2, 7):
    import pandas.io.excel

import pandas
print("pandas.__version__ = %r" % pandas.__version__)
assert pandas.__version__ == '0.19.2'

if int(os.getenv('GUI_TEST', 0)):
    pandas.test()
