copy setup.cfg.template setup.cfg
if errorlevel 1 exit 1

set INCLUDE=%LIBRARY_INC%;%LIBRARY_INC%\freetype2
REM %INCLUDE%

python setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

del %SP_DIR%\*.pth
rd /s /q %SP_DIR%\dateutil
rd /s /q %SP_DIR%\numpy
rd /s /q %SP_DIR%\__pycache__
rd /s /q %SP_DIR%\PyQt4
