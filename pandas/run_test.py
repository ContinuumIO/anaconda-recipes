import pandas._period
import pandas._sparse
import pandas._testing
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

import sys
if sys.version_info >= (2, 7):
    import pandas.io.excel

import pandas
print("pandas.__version__ = %r" % pandas.__version__)

pandas.test()
