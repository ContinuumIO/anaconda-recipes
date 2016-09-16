xcopy /s "C:\Program Files (x86)\NSIS" %PREFIX%\NSIS\
if errorlevel 1 exit 1

copy %PREFIX%\NSIS\COPYING %SRC_DIR%\
if errorlevel 1 exit 1

%SYS_PYTHON% %RECIPE_DIR%\add_deps.py
if errorlevel 1 exit 1
