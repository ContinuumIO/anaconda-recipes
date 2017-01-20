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

:: Fix for https://sourceforge.net/p/pywin32/mailman/message/29498528/
:: although on that bug report Glenn Linderman claims this fix does
:: not work, it seems to work fine. I attempted a fix in the source
:: code (and the upstream developers have clearly thought about it)
:: but the fact is win32api auto-imports pywintypes??.dll as can be
:: seen from:
:: ntldd.exe /c/aroot/stage/Lib/site-packages/win32/win32api.pyd
::         pywintypes36.dll => not found
:: due to: win32/src/PyWinTypes.h:
:: define PYWINTYPES_EXPORT __declspec(dllimport)
:: .. and ..
:: pragma comment(lib,"pywintypes.lib")
:  .. and then (at least): win32/src/win32apimodule.cpp
:: PYWINTYPES_EXPORT PyObject *PyWin_NewUnicode(PyObject *self, PyObject *args);
:: therefore copying is the only recourse. At first glance, it may
:: seem that moving these DLLs would work, but _win32sysloader.cpp
:: expects to find two DLLs in site-packages/pywin32_system32
:: My attempted fix is in import-pywintypes-from-win32api.patch
:: An actual fix would be to make win32api a Python module that
:: first imports pywintypes and after that imports _win32api.
copy %PREFIX%\Lib\site-packages\pywin32_system32\*.dll %PREFIX%\Lib\site-packages\win32\

robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.MFC" "%LIBRARY_BIN%" *.dll /E
:: UCRT has no ATL dlls: https://msdn.microsoft.com/en-us/library/ms235284(v=vs.140).aspx
if %UCRT_BUILD%==1 goto no_atl_dlls
robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.ATL" "%LIBRARY_BIN%" *.dll /E
:no_atl_dlls

if %PY3K%==1 (
   del %PREFIX%\Lib\lib2to3\*.pickle
)

exit 0
