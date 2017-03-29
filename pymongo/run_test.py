import platform

import pymongo

if platform.machine() != 'ppc64le':
    client = pymongo.MongoClient("ilan-desk", 27017)
    db = client.test
    lst = [item['x'] for item in db.my_collection.find()]
    print(lst)
    assert lst == []
