%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

del %PREFIX%\Scripts\pytest.bat
if errorlevel 1 exit 1

del %PREFIX%\Scripts\easy_install-*
