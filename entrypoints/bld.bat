move entrypoints.py %SP_DIR%\
if errorlevel 1 exit 1

%PYTHON% -c "import entrypoints"
if errorlevel 1 exit 1
