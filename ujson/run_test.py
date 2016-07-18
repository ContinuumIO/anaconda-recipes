import ujson

r = ujson.dumps([{"key": "value"}, 81, True])
assert r == '[{"key":"value"},81,true]'

r = ujson.loads("""[{"key": "value"}, 81, true]""")
assert r == [{u'key': u'value'}, 81, True]
