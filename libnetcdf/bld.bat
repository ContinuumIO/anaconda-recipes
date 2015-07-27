mkdir %SRC_DIR%\build
cd %SRC_DIR%\build

set HDF5_DIR=%LIBRARY_PREFIX%\cmake
cmake %SRC_DIR% -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DENABLE_TESTS=OFF -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -G"%CMAKE_GENERATOR%" 
if errorlevel 1 exit 1

cmake --build .
if errorlevel 1 exit 1

cmake --build . --target INSTALL
if errorlevel 1 exit 1

REM remove msvc redist files
cd %LIBRARY_BIN%
rm msvc*.dll
rm Microsoft.VC90.CRT.manifest
