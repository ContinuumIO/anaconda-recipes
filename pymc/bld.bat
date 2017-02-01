set COMP_DIR=C:\Program Files (x86)\IntelSWTools\compilers_and_libraries_2016.1.146\windows

set DISTUTILS_USE_SDK=1
set MSSdk=1

set VS=vs2010
if %PY_VER%==3.5 set VS=vs2015
if %PY_VER%==3.6 set VS=vs2015
if %VS%==vs2015 (
    set "PY_VCRUNTIME_REDIST=%LIBRARY_BIN%\vcruntime140.dll"
)

if "%ARCH%"=="64" (
    set INTEL_ARCH=intel64
    set MSVS_ARCH=amd64
) else (
    set INTEL_ARCH=ia32
    set MSVS_ARCH=x86
)

set TARGET_PLATFORM=
call "%COMP_DIR%\bin\ifortvars.bat" %INTEL_ARCH% %VS%

if %VS_YEAR%==2008 (
    call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" %MSVS_ARCH%
)
set "MKLROOT=%LIBRARY_PREFIX%"

%PYTHON% setup.py install
if errorlevel 1 exit 1
