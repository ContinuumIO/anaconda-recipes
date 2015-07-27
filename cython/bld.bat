python setup.py install
if errorlevel 1 exit 1

if %PY3K%==1 (
    del %PREFIX%\Lib\lib2to3\*.pickle
)
