set LIB=%LIBRARY_LIB%;%LIB%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%

%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

rd /s /q %LIBRARY_LIB%
rd /s /q %SP_DIR%\cffi
rd /s /q %SP_DIR%\pycparser
del %SCRIPTS%\easy_install*
