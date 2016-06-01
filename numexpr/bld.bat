copy %RECIPE_DIR%\site-mkl-%SUBDIR%.cfg site.cfg
if errorlevel 1 exit 1

%SCRIPTS%\replace.exe @PREFIX@ %PREFIX% site.cfg
if errorlevel 1 exit 1

%PYTHON% setup.py install
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\numpy
