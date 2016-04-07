python setup.py install
if errorlevel 1 exit 1

del %SCRIPTS%\coverage*
if errorlevel 1 exit 1
