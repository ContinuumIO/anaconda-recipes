import os
import sys

import matplotlib
import matplotlib.pyplot
import matplotlib._cntr
import matplotlib._delaunay
import matplotlib._image
import matplotlib._path
import matplotlib._png
import matplotlib._tri
import matplotlib.backends._backend_agg
import matplotlib.ft2font
import matplotlib.ttconv
if sys.platform != 'win32':
    import matplotlib.backends._tkagg

import pylab
import mpl_toolkits

if int(os.getenv('GUI_TEST', 0)):
    assert matplotlib.rcParams['backend.qt5'] == 'PyQt5'

    import matplotlib.pyplot as plt
    plt.ioff()
    plt.title('If this window displays, success: CLOSE TO CONTINUE TESTS')
    plt.plot([1,2,5,9])
    plt.show()
