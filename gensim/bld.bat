%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\numpy
