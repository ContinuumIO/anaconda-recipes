%PYTHON% setup.py install
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\numpy
rd /s /q %SP_DIR%\scipy
