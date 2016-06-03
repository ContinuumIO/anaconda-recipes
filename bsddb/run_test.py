import bsddb


db = bsddb.btopen('spam.db', 'c')
for i in range(10):
    db['%d'%i] = '%d'% (i*i)

assert db['3'] == '9'
assert db.keys() == ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
