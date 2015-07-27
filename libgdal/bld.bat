REM build

if "%ARCH%"=="64" (
    set WIN64="WIN64=YES"
) else (
    set WIN64=
)

nmake /f makefile.vc ^
    %WIN64% ^
    GDAL_HOME=%LIBRARY_PREFIX% ^
    BINDIR=%LIBRARY_BIN% ^
    LIBDIR=%LIBRARY_LIB% ^
    INCDIR=%LIBRARY_INC% ^
    DATADIR=%LIBRARY_PREFIX%\data ^
    HDF5_LIB=%LIBRARY_LIB%\hdf5.lib ^
    HDF5_DIR=%LIBRARY_PREFIX% ^
    NETCDF_LIB=%LIBRARY_LIB%\netcdf.lib ^
    NETCDF_INC_DIR=%LIBRARY_INC% ^
    NETCDF_SETTING=yes
if errorlevel 1 exit 1

nmake /f makefile.vc devinstall ^
    %WIN64% ^
    GDAL_HOME=%LIBRARY_PREFIX% ^
    BINDIR=%LIBRARY_BIN% ^
    LIBDIR=%LIBRARY_LIB% ^
    INCDIR=%LIBRARY_INC% ^
    DATADIR=%LIBRARY_PREFIX%\data ^
    HDF5_LIB=%LIBRARY_LIB%\hdf5.lib ^
    HDF5_DIR=%LIBRARY_PREFIX% ^
    NETCDF_LIB=%LIBRARY_LIB%\netcdf.lib ^
    NETCDF_INC_DIR=%LIBRARY_INC% ^
    NETCDF_SETTING=yes
if errorlevel 1 exit 1
