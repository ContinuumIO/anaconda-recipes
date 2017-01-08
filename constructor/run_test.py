import constructor

print('constructor version:', constructor.__version__)
assert constructor.__version__ == '1.5.1'

import constructor.tests
constructor.tests.main()
