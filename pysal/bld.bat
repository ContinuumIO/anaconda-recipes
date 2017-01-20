del /q pysal\examples\snow_maps\*~

"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1
