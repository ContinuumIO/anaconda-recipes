%PYTHON% setup.py install
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\networkx-%PKG_VERSION%-py%PY_VER%.egg\share
if errorlevel 1 exit 1
