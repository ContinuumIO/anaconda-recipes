%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

if "%DISTRO_BUILD%" == "0" (
    rd /s /q %SCRIPTS%
)
