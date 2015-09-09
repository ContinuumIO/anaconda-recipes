xcopy /S %SRC_DIR% %LIBRARY_PREFIX%
if errorlevel 1 exit 1

REM move docs to correct place
xcopy /S %LIBRARY_PREFIX%\share\graphviz\doc %LIBRARY_PREFIX%\share\doc\graphviz
rd /S /Q %LIBRARY_PREFIX%\share\graphviz\doc
if errorlevel 1 exit 1

del %LIBRARY_PREFIX%\bld.bat
if errorlevel 1 exit 1
