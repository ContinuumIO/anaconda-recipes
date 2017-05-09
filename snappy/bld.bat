cd %SRC_DIR%
mkdir snappy-msvc
cd snappy-msvc
copy /y %RECIPE_DIR%\snappy-msvc%VS_MAJOR%\* %CD%

set SLN_FILE=snappy.sln
set SLN_CFG=Release
if "%ARCH%"=="32" (set SLN_PLAT=Win32) else (set SLN_PLAT=x64)
if "%ARCH%"=="32" (set OUTDIR_PLAT=Release) else (set OUTDIR_PLAT=x64\Release)

copy %RECIPE_DIR%\snappy-stubs-public.h %SRC_DIR%\snappy-stubs-public.h
REM Build step
if %VS_MAJOR% LSS 14 goto LESS_THAN_14
devenv "%SLN_FILE%" /Build "%SLN_CFG%|%SLN_PLAT%" /Project snappy
goto END
:LESS_THAN_14
devenv "%SLN_FILE%" /Build "%SLN_CFG%|%SLN_PLAT%"
:END
if errorlevel 1 exit 1
mkdir %PREFIX%\Library\lib
mkdir %PREFIX%\Library\include
mkdir %PREFIX%\Library\share\doc\snappy
copy %OUTDIR_PLAT%\snappy.lib %PREFIX%\Library\lib\
copy ..\snappy.h %PREFIX%\Library\include\
copy ..\snappy-c.h %PREFIX%\Library\include\
copy ..\snappy-sinksource.h %PREFIX%\Library\include\
copy ..\snappy-stubs-public.h %PREFIX%\Library\include\
copy ..\COPYING %PREFIX%\Library\share\doc\snappy\
copy ..\ChangeLog %PREFIX%\Library\share\doc\snappy\
copy ..\NEWS %PREFIX%\Library\share\doc\snappy\
copy ..\README %PREFIX%\Library\share\doc\snappy\
copy ..\format_description.txt %PREFIX%\Library\share\doc\snappy\
copy ..\framing_format.txt %PREFIX%\Library\share\doc\snappy\
if errorlevel 1 exit 1
