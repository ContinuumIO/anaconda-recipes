rd /s /q envisage\tests

%PYTHON% setup.py install
if errorlevel 1 exit 1
