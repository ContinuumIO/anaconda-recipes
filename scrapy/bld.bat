%PYTHON% setup.py install --single-version-externally-managed --root=C:\
if errorlevel 1 exit 1

for /d %%i in ("%SP_DIR%\cryptography*") do rd /s /q "%%i"
