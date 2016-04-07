%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

if %PY3K%==0 (
    del %SP_DIR%\gevent\_socket3.py
)
