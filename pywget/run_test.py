import wget
from os.path import getsize

url = 'http://continuum.io/media/img/continuum_analytics_logo.png'
filename = wget.download(url)
assert filename == 'continuum_analytics_logo.png'
assert getsize(filename) == 16046
