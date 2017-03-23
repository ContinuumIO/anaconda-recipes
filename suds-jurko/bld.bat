"%PYTHON%" setup.py install --single-version-externally-managed --record record.txt
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\tests
