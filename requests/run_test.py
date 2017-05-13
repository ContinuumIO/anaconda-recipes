import requests
import requests.packages
import requests.packages.chardet
import requests.packages.idna
import requests.packages.urllib3

print('requests.__version__: %s' % requests.__version__)
assert requests.__version__ == '2.14.2'
