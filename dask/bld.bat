%PYTHON% setup.py install --single-version-externally-managed --root=C:\
if errorlevel 1 exit 1

if %PY3K%==1 (
    rd /s /q %SP_DIR%\numpy
    rd /s /q %SP_DIR%\dateutil
    rd /s /q %SP_DIR%\toolz
REM    rd /s /q %SP_DIR%\__pycache__
)
