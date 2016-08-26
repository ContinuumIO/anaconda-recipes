import re
import os
from subprocess import check_call
from os.path import isdir, join

BITS = int(os.environ['ARCH'])
PREFIX = os.environ['PREFIX']
ANA_PY = os.environ['ANA_PY']

if ANA_PY.startswith('2'):
    msvc_dir = r'C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC'
    msvc_rt_dir = msvc_dir + {
        32: r'\redist\x86\Microsoft.VC90.CRT',
        64: r'\redist\amd64\Microsoft.VC90.CRT',
    }[BITS]
    msvc_ver = '90'
elif ANA_PY.startswith('3'):
    msvc_dir = r'C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC'
    msvc_rt_dir = msvc_dir + {
        32: r'\redist\x86\Microsoft.VC100.CRT',
        64: r'\redist\x64\Microsoft.VC100.CRT',
    }[BITS]
    msvc_ver = '100'
else:
    raise Exception("Did not expect: %r" % ANA_PY)

#msvcr90_dll = join(msvc_rt_dir, 'msvcr90.dll')
PCbuild = join(PREFIX, 'PCbuild')
libs_dir = join(PREFIX, 'libs')
py_a = join(libs_dir, 'libpython%s.a' % ANA_PY)
py_def = join(PCbuild, 'python%s.def' % ANA_PY)
msvc_a = join(libs_dir, 'libmsvcr%s.a' % msvc_ver)
msvc_def = join(PCbuild, 'msvcr%s.def' % msvc_ver)
mingw_bin = join(PREFIX, 'MinGW', 'bin')
dlltool = join(mingw_bin, 'dlltool')


if not isdir(PCbuild):
    os.mkdir(PCbuild)

def write_def(out_path, dll_fn, lib_path, regex):
    pat = re.compile(regex)
    pipe = os.popen('%s -Cs "%s"' % (join(mingw_bin, 'nm'), lib_path))
    fo = open(out_path, 'w')
    fo.write('LIBRARY %s\n' % dll_fn)
    fo.write('EXPORTS\n')
    for line in pipe.readlines():
        m = pat.match(line)
        if m:
            fo.write(m.group(1) + '\n')
    fo.close()
    pipe.close()

dll_fn = 'python%s.dll' % ANA_PY
regex = {32: r'^_imp__(.+) in ' + dll_fn,
         64: r'^__imp_(.+) in ' + dll_fn}[BITS]
write_def(py_def, dll_fn, join(libs_dir, 'python%s.lib' % ANA_PY), regex)
check_call([dlltool, '--dllname', dll_fn, '--def', py_def,
                     '--output-lib', py_a], cwd=PCbuild)

regex = r'^_imp_(.+) in MSVCR%s\.dll' % msvc_ver
dll_fn = 'MSVCR%s.dll' % msvc_ver
write_def(msvc_def, dll_fn, join(msvc_dir, 'lib', 'msvcrt.lib'), regex)
check_call([dlltool, '--dllname', dll_fn, '--def', msvc_def,
                     '--output-lib', msvc_a], cwd=PCbuild)

with open(join(PREFIX, 'Lib', 'distutils', 'distutils.cfg'), 'w') as fo:
    fo.write("[build]\n"
             "compiler=mingw32\n")
