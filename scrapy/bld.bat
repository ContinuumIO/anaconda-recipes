%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

for /d %%i in ("%SP_DIR%\cryptography*") do rd /s /q "%%i"
