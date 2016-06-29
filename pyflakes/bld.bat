mkdir bin
echo dummy > bin\pyflakes

%PYTHON% setup.py install
if errorlevel 1 exit 1
