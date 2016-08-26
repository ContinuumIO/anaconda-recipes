REM setlocal enabledelayedexpansion

%PYTHON% setup.py install
if errorlevel 1 exit 1

for /d %%i in ("%SP_DIR%\cryptography*") do rd /s /q "%%i"
