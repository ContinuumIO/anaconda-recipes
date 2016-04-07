import string
import datrie

trie = datrie.Trie(string.ascii_lowercase)
trie[u'foo'] = 5

assert u'foo' in trie
