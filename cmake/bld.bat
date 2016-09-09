:: move bin\* %LIBRARY_BIN%\
:: if errorlevel 1 exit 1

:: move share %LIBRARY_PREFIX%\
:: if errorlevel 1 exit 1

set CMAKE_GENERATOR=NMake Makefiles JOM
mkdir build
cd build

curl -SLO https://cmake.org/files/v3.6/cmake-3.6.1-win32-x86.zip
unzip cmake-3.6.1-win32-x86.zip
set PATH=%CD%\cmake-3.6.1-win32-x86\bin;%PATH%

cmake -G "%CMAKE_GENERATOR%" ^
         -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
         -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
         -DCMAKE_BUILD_TYPE=Release ^
         -DBUILD_SHARED_LIBS=True .. ^
         -DBUILD_QtDialog=True

if errorlevel 1 exit 1

cmake --build . --config Release --target all
cmake --build . --config Release --target install
if errorlevel 1 exit 1
