"%PYTHON%" setup.py build_ext install --single-version-externally-managed --record=null
if errorlevel 1 exit 1
