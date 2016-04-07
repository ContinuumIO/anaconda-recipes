"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

if %PY3K% == 1 (
    rd /s /q %SP_DIR%\win32
    rd /s /q %SP_DIR%\win32com
    rd /s /q %SP_DIR%\__pycache__
)
