%PYTHON% setup.py install
if errorlevel 1 exit 1

copy "%RECIPE_DIR%\no_elevation.manifest" "%PREFIX%\Scripts\bspatch4.exe.manifest"
