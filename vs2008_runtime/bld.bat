setlocal enabledelayedexpansion
set MSC_VER=9
set VC_PATH=x86
if "%ARCH%"=="64" (
   set VC_PATH=amd64
)

robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.CRT" "%LIBRARY_BIN%" *.dll /E
robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.CRT" "%PREFIX%" *.dll /E
if %ERRORLEVEL% LSS 8 exit 0
