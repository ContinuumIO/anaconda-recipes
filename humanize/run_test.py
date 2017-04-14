import humanize

assert humanize.intcomma(12345) == '12,345'
assert humanize.intword(123455913) == '123.5 million'
assert humanize.naturalsize(1000000, binary=True) == '976.6 KiB'
assert humanize.fractional(0.3) == '3/10'
