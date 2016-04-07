import sys, os, shutil
from os import path

platform = sys.argv[1]
py_ver_nodot = sys.argv[2]
pkg = sys.argv[3]
ver = sys.argv[4]
src_dir = sys.argv[5]
build_dir = sys.argv[6]
stage_dir = sys.argv[7]

if sys.platform == 'win32':
    # Remove some of the scripts that we don't want to put in the package
    os.remove(path.join(stage_dir, 'Python/Scripts/pywin32_postinstall.py'))
    os.remove(path.join(stage_dir, 'Python/Scripts/pywin32_testall.py'))
    # Move the dll's
    w32_sys = path.join(stage_dir, 'Python/Lib/site-packages/pywin32_system32')
    for f in os.listdir(w32_sys):
        if path.isfile(path.join(stage_dir, 'Python', f)):
            os.remove(path.join(stage_dir, 'Python', f))
        shutil.move(path.join(w32_sys, f), path.join(stage_dir, 'Python'))
    os.rmdir(w32_sys)
else:
    raise RuntimeError('unimplemented platform')
