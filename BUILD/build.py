import os
import sys
import json
import yaml
import subprocess
from os.path import isfile, join


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


def build(recipe_dir):
    if sys.platform == 'win32':
        cmd = [sys.executable,
               join(sys.prefix, 'Scripts', 'conda-build-script.py')]
    else:
        cmd = [sys.executable, join(sys.prefix, 'bin', 'conda-build')]
    cmd.extend(['--python', '27',
                '--numpy', '111',
                recipe_dir])
    print ' '.join(cmd)

    env = dict(os.environ)
    env['FEATURE_NOMKL'] = '0'
    env['FEATURE_DEBUG'] = '0'
    subprocess.check_call(cmd, env=env)


if __name__ == '__main__':
    for recipe_dir, name in get_recipes('osx-64:py27'):
        print recipe_dir
        try:
            build(recipe_dir)
            result = 'OK'
        except subprocess.CalledProcessError:
            result = 'FAILED'
        with open('result.txt', 'a') as f:
            f.write('%-20s %s\n' % (name, result))
