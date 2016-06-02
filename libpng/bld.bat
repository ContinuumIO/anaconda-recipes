mkdir build
cd build

REM Configure step
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% %SRC_DIR%
if errorlevel 1 exit 1

cmake --build . --target INSTALL --config Release
if errorlevel 1 exit 1

REM Make copies of the .lib files without the embedded version number
copy %LIBRARY_LIB%\libpng16_static.lib %LIBRARY_LIB%\libpng_static.lib
copy %LIBRARY_LIB%\libpng16.lib %LIBRARY_LIB%\libpng.lib
REM Matplotlib goes looking for this
copy %LIBRARY_LIB%\libpng16.lib %LIBRARY_LIB%\png.lib
