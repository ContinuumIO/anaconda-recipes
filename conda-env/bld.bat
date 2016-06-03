%PYTHON% setup.py install
if errorlevel 1 exit 1

IF EXIST %SCRIPTS%\.conda-env-post-link.bat del %SCRIPTS%\.conda-env-post-link.bat
