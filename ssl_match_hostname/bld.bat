"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

del %SP_DIR%\backports\__init__*
echo "Done."
