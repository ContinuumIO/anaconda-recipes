cd %SRC_DIR%
mkdir build
cd build

cmake %SRC_DIR% -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --build . --target install
if errorlevel 1 exit 1
