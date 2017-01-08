copy %RECIPE_DIR%\__init__.py %SRC_DIR%\
if errorlevel 1 exit 1

copy %RECIPE_DIR%\setup.py %SRC_DIR%\
if errorlevel 1 exit 1

%PYTHON% setup.py install
if errorlevel 1 exit 1

copy %LIBRARY_BIN%\yaml.dll %SP_DIR%\ruamel_yaml\
if errorlevel 1 exit 1

del %SP_DIR%\*.egg*
