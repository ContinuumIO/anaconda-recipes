from werkzeug.security import safe_str_cmp


assert safe_str_cmp('bar', 'bar')
assert safe_str_cmp(u'baz', u'baz')
assert safe_str_cmp(u'zas', 'zas')
assert safe_str_cmp('asd', u'asd')
