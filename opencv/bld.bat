cd %SRC_DIR%
mkdir build
cd build

cmake %SRC_DIR% -DCMAKE_INSTALL_PREFIX=%PREFIX% -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --build . --target install
if errorlevel 1 exit 1

