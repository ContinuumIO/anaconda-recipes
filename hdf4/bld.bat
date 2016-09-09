set LIB=%LIBRARY_LIB%;%LIB%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%;%RECIPE_DIR%

mkdir build
cd build

:: Configure step.
cmake -G "%CMAKE_GENERATOR%" ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D HDF4_BUILD_HL_LIB=ON ^
      -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -D ZLIB_LIBRARY=%LIBRARY_LIB%\zlibstatic.lib ^
      -D ZLIB_INCLUDE_DIR=%LIBRARY_INC% ^
      -D JPEG_LIBRARY=%LIBRARY_LIB%\jpeg.lib ^
      -D JPEG_INCLUDE_DIR=%LIBRARY_INC% ^
      -D HDF4_BUILD_FORTRAN=NO ^
      -D HDF4_ENABLE_NETCDF=NO ^
      -D BUILD_SHARED_LIBS:BOOL=ON ^
      -D CMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
      -D CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=ON ^
      -D CMAKE_TRY_COMPILE_CONFIGURATION=Release ^
      %SRC_DIR%
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release --target INSTALL
if errorlevel 1 exit 1

:: Test.
ctest -C Release
if errorlevel 1 exit 1
