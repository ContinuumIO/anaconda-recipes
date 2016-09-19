import glob
import os
import sys

PREFIX = os.environ['PREFIX']
LIBQT5 = os.path.join(PREFIX, 'Library', 'lib')
# Qt5 installs .prl files with hard-coded prefixes containing \\\\ path
# separators, which conda does not know how to replace on install.
# This script searches for such paths, and replaces the path separators
# with /.
PRL_PREFIX = LIBQT5.replace('\\', '\\\\')
# must include an empty string in the *last* position of this list:
LIBS = ['\\\\Qt5Core.lib', '\\\\Qt5Gui.lib', '\\\\Qt5Widgets.lib', '']

ORIG_SRC_DIR = os.environ['SRC_DIR'].replace('\\', '/')
TEMP_SRC_DIR = sys.argv[1].replace('\\', '/')

filenames = glob.glob('%s\\*.prl' % LIBQT5)

for filename in filenames:
    with open(filename, 'r') as f:
        old_data = f.read()
    for lib in LIBS:
        old_path = PRL_PREFIX + lib
        new_path = '"%s"' % old_path.replace('\\\\', '/')
        new_data = old_data.replace(old_path, new_path)
        new_data = new_data.replace(TEMP_SRC_DIR, ORIG_SRC_DIR)
    if new_data == old_data:
        continue
    with open(filename, 'wb') as f:
        f.write(new_data.encode('utf8'))
