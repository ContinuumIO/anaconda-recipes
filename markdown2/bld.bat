%PYTHON% setup.py install
if errorlevel 1 exit 1

del %PREFIX%\Scripts\markdown2.py
