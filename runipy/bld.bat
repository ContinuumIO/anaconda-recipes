%PYTHON% setup.py install --single-version-externally-managed --root=C:\
if errorlevel 1 exit 1

if %PY3K%==1 (
    rd /s /q %SP_DIR%\__pycache__
    if errorlevel 1 echo Error
)
