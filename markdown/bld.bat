%PYTHON% setup.py install
if errorlevel 1 exit 1

REM Remove scripts directory
rd /s /q %SCRIPTS%\
