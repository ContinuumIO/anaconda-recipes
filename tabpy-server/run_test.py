from os.path import dirname, isfile, join

import tabpy_server

path = join(dirname(tabpy_server.__file__), 'static', 'tableau.png')
assert isfile(path), path
