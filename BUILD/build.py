import os
import sys
import json
import yaml
import subprocess
from os.path import isfile, join
from optparse import OptionParser


PY_ALLOWED = ('27', '35')


def get_recipes(filter):
    with open('support.json') as fi:
        supported = json.load(fi)

    for dn in sorted(os.listdir('..')):
        recipe_dir = join('..', dn)
        meta_path = join(recipe_dir, 'meta.yaml')
        if not isfile(meta_path):
            continue
        with open(meta_path) as fi:
            data = fi.read()
        name = yaml.load(data)['package']['name']
        if name not in supported:
            continue
        sl = supported[name]
        if sl == 'all':
            yield recipe_dir, name
        else:
            assert isinstance(sl, list)
            if filter in sl:
                yield recipe_dir, name


def build(recipe_dir, py_ver='27'):
    if sys.platform == 'win32':
        cmd = [sys.executable,
               join(sys.prefix, 'Scripts', 'conda-build-script.py')]
    else:
        cmd = [sys.executable, join(sys.prefix, 'bin', 'conda-build')]
    cmd.extend(['--python', py_ver,
                '--numpy', '111',
                recipe_dir])
    print ' '.join(cmd)

    env = dict(os.environ)
    env['FEATURE_NOMKL'] = '0'
    env['FEATURE_DEBUG'] = '0'
    subprocess.check_call(cmd, env=env)


def main():
    from conda.config import subdir

    p = OptionParser(
        usage="usage: %prog [options]",
        description="runs conda-build on recipes")

    p.add_option("--py",
                 action="store",
                 default="27",
                 help="Python version to build against, defaults to %default")

    opts, args = p.parse_args()
    if args:
        p.error("No arguments expected")
    if opts.py not in PY_ALLOWED:
        p.error("Did not expect --py=%s not in: %s" % (opts.py,
                                                       PY_ALLOWED))

    filter = '%s:py%s' % (subdir, opts.py)
    print 'filter: %s' % filter

    for recipe_dir, name in get_recipes(filter):
        try:
            build(recipe_dir, opts.py)
            result = 'OK'
        except subprocess.CalledProcessError:
            result = 'FAILED'
        with open('result.txt', 'a') as f:
            f.write('%-20s %s\n' % (name, result))


if __name__ == '__main__':
    main()
