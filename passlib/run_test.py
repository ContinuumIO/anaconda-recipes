from passlib.hash import sha256_crypt

hash = sha256_crypt.encrypt("toomanysecrets")
print(hash)

assert sha256_crypt.verify("toomanysecrets", hash) is True
assert sha256_crypt.verify("joshua", hash) is False
