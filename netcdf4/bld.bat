set HDF5_DIR=%LIBRARY_PREFIX%
set NETCDF4_DIR=%LIBRARY_PREFIX%
set ZLIB_DIR=%LIBRARY_PREFIX%

%PYTHON% setup.py install
if errorlevel 1 exit 1
