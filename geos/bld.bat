cmake -G "NMake Makefiles" -DCMAKE_PREFIX_PATH=%PREFIX% -DCMAKE_INSTALL_PREFIX:PATH=%PREFIX% -D CMAKE_BUILD_TYPE=Release .
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1

