import os
import ruamel_yaml
from ruamel_yaml.comments import CommentedSeq, CommentedMap
from ruamel_yaml.scanner import ScannerError

assert ruamel_yaml.load('''\
A: 1
B:
  - Cef
  - def
''') == {'A': 1, 'B': ['Cef', 'def']}

print('ruamel_yaml.__version__: %s' % ruamel_yaml.__version__)
assert ruamel_yaml.__version__ == '0.11.14'
