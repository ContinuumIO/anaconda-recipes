setlocal enabledelayedexpansion
REM NOTE: this calls python files directly during the build process, relying on your file associations.
REM    when building this recipe, you need to associate python files with C:\aroot\stage\pythonw.exe for best results.

:: UCRT builds requires using Windows 8.1 SDK and that
:: does not provide the MAPI headers.
if %PY3K%==1 (
    if %PY_VER% == 3.4 (
        set UCRT_BUILD=0
    ) else (
        set UCRT_BUILD=1
    )
) else (
    set UCRT_BUILD=0
)

if %UCRT_BUILD%==1 (
    set "INCLUDE=%INCLUDE%%RECIPE_DIR%\Outlook2010MAPIHeaderFiles;"
)

if %PY3K%==1 (
  python setup3.py build -c msvc
  if errorlevel 1 exit 1
  python setup3.py install --skip-build
) else (
  python setup.py build -c msvc
  if errorlevel 1 exit 1
  python setup.py install --skip-build
)

:: below here, we copy MFC and ATL redistributable DLLs into places that should be on PATH
set VC_PATH=x86
if "%ARCH%"=="64" (
    set VC_PATH=x64
)

if %UCRT_BUILD%==1 (
    set MSC_VER=14
) else (
    set MSC_VER=10
    if %PY_VER% == 2.7 (
        set MSC_VER=9
        if "%ARCH%"=="64" (
            set VC_PATH=amd64
        )
    )
)

move %PREFIX%\pythoncom%PY_VER:.=%.dll %LIBRARY_BIN%\
move %PREFIX%\pywintypes%PY_VER:.=%.dll %LIBRARY_BIN%\

robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.MFC" "%LIBRARY_BIN%" *.dll /E
:: UCRT has no ATL dlls: https://msdn.microsoft.com/en-us/library/ms235284(v=vs.140).aspx
if %UCRT_BUILD%==1 goto no_atl_dlls
robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.ATL" "%LIBRARY_BIN%" *.dll /E
:no_atl_dlls

if %PY3K%==1 (
   del %PREFIX%\Lib\lib2to3\*.pickle
)

exit 0
