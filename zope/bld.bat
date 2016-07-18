set BP=%SP_DIR%\zope
mkdir %BP%
copy %RECIPE_DIR%\__init__.py %BP%\
%PYTHON% -c "import zope"
