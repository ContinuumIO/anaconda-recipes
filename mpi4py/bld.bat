move %SRC_DIR%\mpi4py %SP_DIR%
move %SRC_DIR%\mpi4py-%PKG_VERSION%.dist-info %SP_DIR%

mkdir %SCRIPTS%
copy %RECIPE_DIR%\pre-link.bat %SCRIPTS%\.mpi4py-pre-link.bat

mkdir %PREFIX%\share
copy %RECIPE_DIR%\msg.txt %PREFIX%\share\.mpi4py.txt

if errorlevel 1 exit 1
