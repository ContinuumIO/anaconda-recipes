"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

rmdir /s /q "%SP_DIR%"\spyplugins
if errorlevel 1 exit 1

del /s /q "%SP_DIR%%"\conda_manager-*-nspkg.pth
if errorlevel 1 exit 1
