import gdbm
import sys


db = gdbm.open('spam.db', 'n')
for i in range(1000):
    db['%d' % i] = '%d'% (i * i)
db.reorganize()

k = db.firstkey()
while k is not None:
    k = db.nextkey(k)

db.close()
del db

if sys.platform == 'darwin':
    # This should work everywhere, but on Linux, I get:
    # gdbm.error: (11, 'Resource temporarily unavailable')
    d = gdbm.open('spam.db', 'r')
    assert d['3'] == '9'
    d.close()
