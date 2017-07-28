mkdir build
cd build

cmake .. -G "%CMAKE_GENERATOR%" ^
        -DBUILD_SHARED_LIBS=ON ^
        -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
        -DCMAKE_BUILD_TYPE=Release
IF %ERRORLEVEL% NEQ 0 exit 1

cmake --build . --config Release --target INSTALL
IF %ERRORLEVEL% NEQ 0 exit 1