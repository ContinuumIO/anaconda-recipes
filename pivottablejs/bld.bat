"%PYTHON%" setup.py install

mkdir %SP_DIR%\notebook
mkdir %SP_DIR%\notebook\static
if errorlevel 1 exit 1

move %SRC_DIR%\static\pivot-ajax %SP_DIR%\notebook\static
if errorlevel 1 exit 1

move %SRC_DIR%\static\pivottable %SP_DIR%\notebook\static
if errorlevel 1 exit 1
