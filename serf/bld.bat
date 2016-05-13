COPY %RECIPE_DIR%\CMakeLists.txt .\CMakeLists.txt

mkdir cmake_build
pushd cmake_build

cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ..\
cmake --build . --target INSTALL --config Release

ROBOCOPY %SRC_DIR% %LIBRARY_INC% *.h /E
if %ERRORLEVEL% GEQ 8 exit 1
REM MOVE %SRC_DIR%\auth %LIBRARY_INC%\
REM MOVE %SRC_DIR%\buckets %LIBRARY_INC%\

exit 0

rem vim:set ts=8 sw=4 sts=4 tw=78 et:
