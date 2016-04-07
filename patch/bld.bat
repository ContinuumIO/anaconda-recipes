copy %SRC_DIR%\bin\patch.exe %LIBRARY_BIN%
copy %RECIPE_DIR%\no_elevation.manifest %LIBRARY_BIN%\patch.exe.manifest
if errorlevel 1 exit 1
