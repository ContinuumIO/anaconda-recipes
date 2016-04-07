setlocal enabledelayedexpansion
REM NOTE: this calls python files directly during the build process, relying on your file associations.
REM    when building this recipe, you need to associate python files with C:\aroot\stage\pythonw.exe for best results.

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

if %PY_VER% == 3.5 (
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

:: This is in-between.  we hit this if no other goto is done.
robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.MFC" "%LIBRARY_BIN%" *.dll /E
if %ERRORLEVEL% LSS 8 exit 0
robocopy "C:\Program Files (x86)\Microsoft Visual Studio %MSC_VER%.0\VC\redist\%VC_PATH%\Microsoft.VC%MSC_VER%0.ATL" "%LIBRARY_BIN%" *.dll /E
if %ERRORLEVEL% LSS 8 exit 0

if %PY3K%==1 (
   del %PREFIX%\Lib\lib2to3\*.pickle
)

exit 0
