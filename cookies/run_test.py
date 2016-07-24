# new cookies.py
from cookies import Cookies, Cookie

cookies = Cookies(rocky='road')
# Can also write explicitly: cookies['rocky'] = Cookie['road']
cookies['rocky'].path = "/cookie"
assert cookies.render_request() == 'rocky=road'
