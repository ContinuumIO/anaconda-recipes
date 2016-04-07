import re
import os
import sys
from os.path import isdir, join

import config


BAT_PROXY = """Foo
@echo off
"""

PY_TMPL = """\
if __name__ == '__main__':
    import sys
    from %s import %s

    sys.exit(%s())
"""

bin_dirname = 'Scripts' if sys.platform == 'win32' else 'bin'

entry_pat = re.compile('\s*(\w+)\s*=\s*(\w+):(\w+)\s*$')


def create_entry_points(info):
    bin_dir = join(config.PREFIX, bin_dirname)

    for item in info['entry_points']:
        m = entry_pat.match(item)
        if m is None:
            sys.exit("Error cound not match entry point: %r" % item)

        cmd, module, func = m.groups()
        if not isdir(bin_dir):
            os.mkdir(bin_dir)

        pyscript = PY_TMPL % (module, func, func)
        if sys.platform == 'win32':
            with open(join(bin_dir, cmd + '-script.py'), 'w') as fo:
                fo.write(pyscript)
            with open(join(bin_dir, cmd + '.bat'), 'w') as fo:
                fo.write(BAT_PROXY)
        else:
            path = join(bin_dir, cmd)
            with open(path, 'w') as fo:
                fo.write('#!%s\n' % config.PYTHON)
                fo.write(pyscript)
