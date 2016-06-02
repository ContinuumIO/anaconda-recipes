from pickleshare import *

db = PickleShareDB('./testpickleshare')
db.clear()

db['hello'] = 15
db['aku ankka'] = [1,2,313]
db['paths/are/ok/key'] = [1,(5,46)]
print(db.keys())
