del transaction\*~
del transaction\tests\*~

"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1
