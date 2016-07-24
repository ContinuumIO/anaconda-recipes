%PYTHON% setup.py build_ext --gdalversion 2.1.0 -I%LIBRARY_INC% -L%LIBRARY_LIB% -lgdal_i
if errorlevel 1 exit 1

%PYTHON% setup.py install --gdalversion 2.1.0 --old-and-unmanageable
if errorlevel 1 exit 1
