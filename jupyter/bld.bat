%PYTHON% setup.py install
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\__pycache__
del %SP_DIR%\jupyter.py*
