%PYTHON% setup.py install
if errorlevel 1 exit 1

REM rd /s /q %SP_DIR%\distribute-%PKG_VERSION%-py%PY_VER%.egg\EGG-INFO
REM move %SRC_DIR%\distribute.egg-info %SP_DIR%

rd /s /q %STDLIB_DIR%\lib2to3
cd %SCRIPTS%
del *.exe
del easy_install-2*
del easy_install-3*
