
%PYTHON% setup.py configure --hdf5=%LIBRARY_PREFIX%
%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

if "%PY3K%"=="1" (
    rd /s /q %SP_DIR%\__pycache__
    rd /s /q %SP_DIR%\pkgconfig
    rd /s /q %SP_DIR%\numpy
)
