from os.path import dirname, isfile, join

import werkzeug
from werkzeug.security import safe_str_cmp


assert safe_str_cmp('bar', 'bar')
assert safe_str_cmp(u'baz', u'baz')
assert safe_str_cmp(u'zas', 'zas')
assert safe_str_cmp('asd', u'asd')

path = join(dirname(werkzeug.__file__), 'debug', 'shared', 'source.png')
assert isfile(path), path
