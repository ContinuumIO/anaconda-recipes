python setup.py install

mkdir %SCRIPTS%
copy %RECIPE_DIR%\pre-link.bat %SCRIPTS%\.mpi4py-pre-link.bat

mkdir %PREFIX%\share
copy %RECIPE_DIR%\msg.txt %PREFIX%\share\.mpi4py.txt

if errorlevel 1 exit 1
