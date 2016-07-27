move setup.py setup.org
if errorlevel 1 exit 1

cat %RECIPE_DIR%\mkl_conf.py setup.org > setup.py
if errorlevel 1 exit 1

"%PYTHON%" setup.py build --compiler=mingw32
if errorlevel 1 exit 1

"%PYTHON%" setup.py install
if errorlevel 1 exit 1
