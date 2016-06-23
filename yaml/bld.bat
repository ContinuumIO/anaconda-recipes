C:\cygwin\bin\unzip %RECIPE_DIR%\vs_anaconda.zip -d .\win32

set SLN_FILE=win32\vs_anaconda\libyaml.sln
set SLN_CFG=Release
if "%ARCH%"=="32" (set SLN_PLAT=Win32) else (set SLN_PLAT=x64)

REM Build step
devenv "%SLN_FILE%" /Build "%SLN_CFG%|%SLN_PLAT%"
if errorlevel 1 exit 1

REM This would be the static lib:
REM copy win32\vs_anaconda\%SLN_PLAT%\Release\yaml.lib %LIBRARY_LIB%\

REM Install step
copy win32\vs_anaconda\DLL\%SLN_PLAT%\Release\yaml.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1
copy win32\vs_anaconda\DLL\%SLN_PLAT%\Release\yaml.dll %LIBRARY_BIN%\
if errorlevel 1 exit 1
copy include\yaml.h %LIBRARY_INC%\
if errorlevel 1 exit 1
