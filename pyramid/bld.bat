%PYTHON% setup.py install
if errorlevel 1 exit 1

del %PREFIX%\Scripts\easy_install*
