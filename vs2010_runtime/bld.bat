setlocal enabledelayedexpansion
set VC_PATH=x86
if "%ARCH%"=="64" (
set VC_PATH=x64
)
set MSC_VER=10

REM Do a quick version check to make sure that we are packaging the DLLs that we say we are
curl -LO https://download.sysinternals.com/files/Sigcheck.zip
7za x Sigcheck.zip
FOR /F "tokens=* skip=1 delims=" %%A in ('sigcheck.exe -q -n -vt "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.CRT\msvcr%MSC_VER%0.dll"') do (
    if not "%%A" == "%PKG_VERSION%" exit 1
)

robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.CRT" "%LIBRARY_BIN%" *.dll /E
robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.CRT" "%PREFIX%" *.dll /E
robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.OpenMP" "%LIBRARY_BIN%" *.dll /E
robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.OpenMP" "%PREFIX%" *.dll /E
if %ERRORLEVEL% LSS 8 exit 0
