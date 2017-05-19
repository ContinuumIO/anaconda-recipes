copy %RECIPE_DIR%\LICENSE.txt %SRC_DIR%
if errorlevel 1 exit 1

if "%ARCH%"=="64" (
    set INTEL_ARCH=intel64
) else (
    set INTEL_ARCH=ia32
)

set INTEL_DIR=C:\Program Files (x86)\IntelSWTools\compilers_and_libraries_2017.1.143\windows
set MKL_DLL_DIR=%INTEL_DIR%\redist\%INTEL_ARCH%_win\mkl

set INTEL_DIR=C:\Program Files (x86)\IntelSWTools\compilers_and_libraries_2016.1.146\windows
set COMP_DLL_DIR=%INTEL_DIR%\redist\%INTEL_ARCH%\compiler

mkdir %PREFIX%\DLLs

copy "%MKL_DLL_DIR%\*.dll" %LIBRARY_BIN%\
if errorlevel 1 exit 1

copy "%MKL_DLL_DIR%\1033\*.dll" %LIBRARY_BIN%\
if errorlevel 1 exit 1

copy "%COMP_DLL_DIR%\*.dll" %LIBRARY_BIN%\
if errorlevel 1 exit 1
