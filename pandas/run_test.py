import pandas._libs.algos
import pandas._libs.groupby
import pandas._libs.hashing
import pandas._libs.hashtable
import pandas._libs.index
import pandas._libs.interval
import pandas._libs.join
import pandas._libs.json
import pandas._libs.lib
import pandas._libs.parsers
import pandas._libs.period
import pandas._libs.reshape
import pandas._libs.sparse
import pandas._libs.testing
import pandas._libs.tslib
import pandas._libs.window
import pandas.io.msgpack._packer
import pandas.io.msgpack._unpacker
import pandas.io.sas._sas
import pandas.util._move

import os
import sys
if sys.version_info >= (2, 7):
    import pandas.io.excel

import pandas
print("pandas.__version__ = %r" % pandas.__version__)
assert pandas.__version__ == '0.20.3'

if int(os.getenv('GUI_TEST', 0)):
    pandas.test()
