mkdir build && cd build

cmake .. -G "%CMAKE_GENERATOR%" ^
	-DBUILD_SHARED_LIBS=ON ^
	-DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
	-DENABLE_ZLIB_COMPRESSION=ON ^
	-DCMAKE_BUILD_TYPE=Release ^
	-DENABLE_DEBUG_LOGGING=ON
IF %ERRORLEVEL% NEQ 0 exit 1

cmake --build . --config Release --target INSTALL
IF %ERRORLEVEL% NEQ 0 exit 1
