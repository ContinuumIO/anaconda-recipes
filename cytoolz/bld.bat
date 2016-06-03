%PYTHON% setup.py install
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\Cython
rd /s /q %SP_DIR%\__pycache__
exit 0
