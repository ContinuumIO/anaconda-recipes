%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

if %PY3K%==1 (
    del %SP_DIR%\mistune.py
    del /s /q %SP_DIR%\__pycache__\
    del /s /q %SP_DIR%\Cython\
)
