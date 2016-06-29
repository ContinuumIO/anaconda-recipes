%PYTHON% setup.py install

REM Remove markup_py.bat from scripts directory
del %SCRIPTS%\markdown_py.bat

if errorlevel 1 exit 1
