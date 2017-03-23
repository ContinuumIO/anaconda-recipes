import sys

import gevent._semaphore
import gevent.libev.corecext

if sys.platform != 'win32':
    import gevent.ares
