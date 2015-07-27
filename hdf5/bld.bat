mkdir build
cd build

REM set environement variables
set HDF5_EXT_ZLIB=zlib.lib

REM configure step
cmake -G "%CMAKE_GENERATOR%" -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% -DBUILD_SHARED_LIBS:BOOL=ON -DHDF5_BUILD_HL_LIB=ON -DHDF5_BUILD_TOOLS:BOOL=ON -DHDF5_ENABLE_Z_LIB_SUPPORT:BOOL=ON %SRC_DIR%
if errorlevel 1 exit 1

REM Build C libraries and tools
devenv HDF5.sln /Build "%RELEASE_TARGET%
if errorlevel 1 exit 1

REM Install step
devenv HDF5.sln /Build "%RELEASE_TARGET%" /Project INSTALL
if errorlevel 1 exit 1

REM remove msvc redist files
cd %LIBRARY_BIN%
rm msvc*.dll
rm Microsoft.VC90.CRT.manifest
