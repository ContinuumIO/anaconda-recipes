import sys
from os.path import join
from distutils.core import setup, Extension


setup(
    name = "gdbm",
    ext_modules = [
        Extension(
            'gdbm', ['gdbmmodule.c'],
            library_dirs = [join(sys.prefix, 'lib')],
            runtime_library_dirs = [join(sys.prefix, 'lib')],
            include_dirs = [join(sys.prefix, 'include')],
            libraries = ['gdbm'],
            )
        ]
)
