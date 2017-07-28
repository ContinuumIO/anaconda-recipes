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
:: SetEnv.Cmd from Windows 7.1 SDK will have set TARGET_PLATFORM=WIN7
:: and that breaks ifortvars.bat where it's only allowed to be one of
:: "linux", "android" or "".
set TARGET_PLATFORM=
call "%COMP_DIR%\bin\ifortvars.bat" %INTEL_ARCH% %VS%

:: Intel Fortran Compilers 2016 Update 3 remove support for vs2008.
:: ifortvars.bat adds vs2010 (or vs2015) to front of PATH to affect
:: this change. So we undo that here in a somewhat horrible manner.
if %VS_YEAR%==2008 (
    call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" %MSVS_ARCH%
)
echo "PATH before scipy build is:"
echo "PATH=%PATH%"
set "MKLROOT=%LIBRARY_PREFIX%"

%PYTHON% -c "import cio_bt.check_msvs"
if errorlevel 1 exit 1

%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1
