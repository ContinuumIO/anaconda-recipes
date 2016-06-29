set INCLUDE=%LIBRARY_INC%
set LIBPATH=%LIBRARY_LIB%
set LIB=%LIBRARY_LIB%

bash %RECIPE_DIR%\prepare.bash /cygdrive/c/anaconda/packages/ruamel_yaml /cygdrive/c/Minonda/conda-bld/work
if errorlevel 1 exit 1

%PYTHON% setup.py install
if errorlevel 1 exit 1

copy %LIBRARY_BIN%\yaml.dll %SP_DIR%\ruamel_yaml\ext\
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\__pycache__
if errorlevel 1 echo nvd
