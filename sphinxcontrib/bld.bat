set BP=%SP_DIR%\sphinxcontrib
mkdir %BP%
copy %RECIPE_DIR%\__init__.py %BP%\
%PYTHON% -c "import sphinxcontrib"
