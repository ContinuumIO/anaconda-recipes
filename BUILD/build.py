import os
import json
import yaml
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
            yield recipe_dir
        else:
            assert isinstance(sl, list)
            if filter in sl:
                yield recipe_dir


if __name__ == '__main__':
    for recipe_dir in get_recipes('osx-64:py27'):
        print recipe_dir
