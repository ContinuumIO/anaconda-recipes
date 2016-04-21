set BP=%SP_DIR%\backports
mkdir %BP%
copy %RECIPE_DIR%\__init__.py %BP%\
%PYTHON% -c "import backports"
