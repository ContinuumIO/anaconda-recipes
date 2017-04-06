"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

touch %SP_DIR%\tabpy_server\__init__.py
if errorlevel 1 exit 1
