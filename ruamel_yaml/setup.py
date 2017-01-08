import os
import sys
from os.path import join
from distutils.core import setup, Extension

from Cython.Build import cythonize

from cio_bt.replace import replace


src_dir = os.getcwd()
os.unlink(join(src_dir, 'ext', '_ruamel_yaml.c'))
os.mkdir(join(src_dir, 'ruamel_yaml'))
for fn in os.listdir(src_dir):
    if not fn.endswith('.py'):
        continue
    dst = join(src_dir, 'ruamel_yaml', fn)
    os.rename(join(src_dir, fn), dst)
    replace([('ruamel.yaml', 'ruamel_yaml')],
            dst, assert_change=False)

replace([('__VERSION__', os.getenv('PKG_VERSION'))],
        join(src_dir, 'ruamel_yaml', '__init__.py'))

replace([('_ruamel_yaml', 'ruamel_yaml._ruamel_yaml')],
        join(src_dir, 'ruamel_yaml', 'cyaml.py'))

replace([('from ruamel.yaml', 'from ruamel_yaml')],
        join(src_dir, 'ext', '_ruamel_yaml.pyx'))

extensions = [Extension(
    "ruamel_yaml._ruamel_yaml",
    ['ext/_ruamel_yaml.pyx'],
    libraries=['yaml'],
    library_dirs=[os.path.join(sys.prefix, 'lib')],
    include_dirs=[os.path.join(sys.prefix, 'include')],
)]

setup(
    name='ruamel_yaml',
    ext_modules=cythonize(extensions),
    packages=['ruamel_yaml'],
)
