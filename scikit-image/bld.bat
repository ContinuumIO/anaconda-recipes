%PYTHON% setup.py install --single-version-externally-managed --root=C:\
if errorlevel 1 exit 1

del %SCRIPTS%\cython.pyc

rd /s /q %SCRIPTS%
rd /s /q %SP_DIR%\numpy
rd /s /q %SP_DIR%\scipy
if %PY3K%==1 (
    rd /s /q %SP_DIR%\__pycache__
    rd /s /q %SP_DIR%\dateutil
    rd /s /q %SP_DIR%\Cython
)
exit 0
