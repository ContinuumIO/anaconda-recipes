%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

del %SCRIPTS%\easy_install*

if %PY3K%==1 (
    rd /s /q %SP_DIR%\__pycache__
    rd /s /q %SP_DIR%\PyQt5
)
echo "Done"
