"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

del %SP_DIR%\*.pth
if errorlevel 1 exit 1
del %SP_DIR%\sockjs\__init__.py
if errorlevel 1 exit 1
touch %SP_DIR%\sockjs\__init__.py
if errorlevel 1 exit 1
