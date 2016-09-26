set MENU_DIR=%PREFIX%\Menu
mkdir %MENU_DIR%

copy %RECIPE_DIR%\jupyter.ico %MENU_DIR%
if errorlevel 1 exit 1

copy %RECIPE_DIR%\menu-windows.json %MENU_DIR%\qtconsole.json
if errorlevel 1 exit 1

%PYTHON% setup.py install
if errorlevel 1 exit 1

del %PREFIX%\Scripts\jupyter-qtconsole
