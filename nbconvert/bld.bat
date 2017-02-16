rd /s /q nbconvert\preprocessors\tests\files
if errorlevel 1 exit 1

"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1
