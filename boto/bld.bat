python setup.py install
if errorlevel 1 exit 1

if "%DISTRO_BUILD%" == "0" (
    rd /s /q %SCRIPTS%
)
