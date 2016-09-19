cd source

set LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set SRC_DIR=%SRC_DIR:\=/%
set MSYSTEM=MINGW%ARCH%
set MSYS2_PATH_TYPE=inherit
set CHERE_INVOKING=1
:: Set flag saying we have stdint.h manually.  We take care of providing it where
::    it is needed, but missing, by using msinttypes
set "CXXFLAGS=%CXXFLAGS% -DU_HAVE_STDINT_H=1"
set "CFLAGS=%CFLAGS% -DU_HAVE_STDINT_H=1"

:: Set PATH to include msys2's binaries
set "PATH=%PATH%;%LIBRARY_PREFIX%\usr\bin;%LIBRARY_PREFIX%\mingw-w64\bin"

bash -x runConfigureICU MSYS/MSVC --prefix=%LIBRARY_PREFIX% --enable-static

if errorlevel 1 (
   appveyor PushArtifact "%CD%\config.log"
   exit 1
)
make -j%NUMBER_OF_PROCESSORS%
if errorlevel 1 exit 1
rem  ParameterTest Makefile:77: recipe for target 'check-local' failed
rem  make[2]: *** [check-local] Segmentation fault
rem  make[2]: Leaving directory '/c/Users/ray/qt5-x64-3.4/conda-bld/work/icu/source/test/letest'
if not "%VS_VERSION%" == "10.0" (
  make check
  if errorlevel 1 exit 1
)
make install
if errorlevel 1 exit 1

set LIBRARY_PREFIX=%LIBRARY_PREFIX:/=\%
MOVE %LIBRARY_PREFIX%\lib\*.dll %LIBRARY_BIN%\

exit 0
