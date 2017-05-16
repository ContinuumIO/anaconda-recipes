copy %RECIPE_DIR%\backend.py graphviz\
if errorlevel 1 exit 1

"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1
