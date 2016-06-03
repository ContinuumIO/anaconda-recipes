import sys
from os.path import join
from distutils.core import setup, Extension


setup(
    name = "bsddb",
    ext_modules = [
        Extension(
            '_bsddb', ['_bsddb.c'],
            depends = ['bsddb.h'],
            library_dirs = [join(sys.prefix, 'lib')],
            runtime_library_dirs = [join(sys.prefix, 'lib')],
            include_dirs = [join(sys.prefix, 'include')],
            libraries = ['db-5.3'],
            )
        ]
)
