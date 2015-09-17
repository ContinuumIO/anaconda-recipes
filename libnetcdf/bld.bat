mkdir %SRC_DIR%\build
cd %SRC_DIR%\build

set HDF5_DIR=%LIBRARY_PREFIX%\cmake

if "%ARCH%" == "64" (
  set CMAKE_GENERATOR="Visual Studio 10 2010 Win64"
) else (
  set CMAKE_GENERATOR="Visual Studio 10 2010"
)

cmake %SRC_DIR% -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DENABLE_TESTS=OFF -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -G %CMAKE_GENERATOR%
if errorlevel 1 exit 1

cmake --build .
if errorlevel 1 exit 1

cmake --build . --target INSTALL
if errorlevel 1 exit 1

REM remove msvc redist files
cd %LIBRARY_BIN%
rm msvc*.dll
