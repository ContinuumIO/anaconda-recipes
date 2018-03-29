:: Set env vars that tell distutils to use the compiler that we put on path
SET DISTUTILS_USE_SDK=1
SET MSSdk=1

:: http://stackoverflow.com/a/26874379/1170370
SET platform=
IF /I [%PROCESSOR_ARCHITECTURE%]==[amd64] set platform=true
IF /I [%PROCESSOR_ARCHITEW6432%]==[amd64] set platform=true

:: the Environment variable VisualStudioVersion is set by devenv.exe
:: if this batch is a child of devenv.exe external tools, we know which version to look at
VisualStudioVersion=14.0

if defined platform (
set VSREGKEY=HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\%VisualStudioVersion%
)  ELSE (
set VSREGKEY=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\%VisualStudioVersion%
)
for /f "skip=2 tokens=2,*" %%A in ('reg query "%VSREGKEY%" /v InstallDir') do SET VSINSTALLDIR=%%B

if not "%VSINSTALLDIR%" == "" (
   set VSINSTALLDIR=%VS140COMNTOOLS%
)

if "%VSINSTALLDIR%" == "" (
   ECHO "Did not find VS in registry or in VS90COMNTOOLS env var - exiting"
   exit 1
)

echo "Found VS2014 at"
echo "%VSINSTALLDIR%"


CALL

SET "VS_VERSION=14.0"
SET "VS_MAJOR=14"
SET "VS_YEAR=2015"

if "%ARCH%" == "64" (
    :: 64-bit
    SET "CMAKE_GENERATOR=Visual Studio %VS_MAJOR% %VS_YEAR% Win64"
) else (
    :: 32-bit
    SET "CMAKE_GENERATOR=Visual Studio %VS_MAJOR% %VS_YEAR%"
)


set "MSYS2_ARG_CONV_EXCL=/AI;/AL;/OUT;/out"
set "MSYS2_ENV_CONV_EXCL=CL"

:: For Python 3.5+, ensure that we link with the dynamic runtime.  See
:: http://stevedower.id.au/blog/building-for-python-3-5-part-two/ for more info
set PY_VCRUNTIME_REDIST=%PREFIX%\\bin\\vcruntime140.dll

CALL %VSINSTALLDIR%\