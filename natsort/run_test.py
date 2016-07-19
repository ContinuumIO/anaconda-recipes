from natsort import natsorted

a = ['a2', 'a9', 'a1', 'a4', 'a10']
b = ['a1', 'a2', 'a4', 'a9', 'a10']
assert natsorted(a) == b

a = ['version-1.9', 'version-2.0', 'version-1.11', 'version-1.10']
b = ['version-1.9', 'version-1.10', 'version-1.11', 'version-2.0']
assert natsorted(a) == b
print("natsort OK")
