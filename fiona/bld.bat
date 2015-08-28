%PYTHON% setup.py build_ext -I%LIBRARY_INC% -L%LIBRARY_LIB% -lgdal_i 
if errorlevel 1 exit 1

%PYTHON% setup.py install --single-version-externally-managed --root=C:\
if errorlevel 1 exit 1

if %PY3K%==1 (
    del %PREFIX%\Lib\lib2to3\*.pickle
)
