setlocal enabledelayedexpansion
set CONDA_DEFAULT_ENV=
%PYTHON% setup.py install
if errorlevel 1 exit 1

mkdir %PREFIX%\etc\fish\conf.d
if errorlevel 1 exit 1

copy %SRC_DIR%\shell\conda.fish %PREFIX%\etc\fish\conf.d
if errorlevel 1 exit 1

copy %RECIPE_DIR%\cio_test.py %SP_DIR%
if errorlevel 1 exit 1
