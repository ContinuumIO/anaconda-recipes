REM ========== actual compile step

if "%ARCH%"=="64" (
   set PLATFORM=x64
   set VC_PATH=x64
   set BUILD_PATH=amd64
) else (
   set PLATFORM=Win32
   set VC_PATH=x86
   set BUILD_PATH=win32
)

:: We've changed importlib (_BACKCOMPAT_MAGIC_NUMBER) so must rebuild importlib.h
copy /Y Python\importlib.h Python\importlib.h.orig
copy /Y Python\importlib_external.h Python\importlib_external.h.orig

msbuild PCbuild\pcbuild.sln /t:_freeze_importlib /p:Configuration=Release /p:Platform=%PLATFORM% /m /p:OutDir=%SRC_DIR%\PCBuild\
:: It is important not to exit upon error here as a deliberate error is caused when importlib*.h are changed.
copy /Y PCbuild\obj\%BUILD_PATH%_Release\_freeze_importlib\importlib.g.h Python\importlib.h
copy /Y PCbuild\obj\%BUILD_PATH%_Release\_freeze_importlib\importlib_external.g.h Python\importlib_external.h
msbuild PCbuild\pcbuild.sln /t:clean
msbuild PCbuild\pcbuild.sln /t:python;pythoncore;pythonw;python3dll /p:Configuration=Release /p:Platform=%PLATFORM% /m /p:OutDir=%SRC_DIR%\PCBuild\

REM ========== add stuff from official python.org installer

set MSI_DIR=\Pythons\%PKG_VERSION%-%ARCH%
for %%x in (DLLs Doc libs tcl Tools) do (
    xcopy /s /y %MSI_DIR%\%%x %PREFIX%\%%x\
    if errorlevel 1 exit 1
)

REM ========== add stuff from our own build

xcopy /s /y %SRC_DIR%\Include %PREFIX%\include\
if errorlevel 1 exit 1

copy /Y %SRC_DIR%\PC\pyconfig.h %PREFIX%\include\
if errorlevel 1 exit 1

for %%x in (python35.dll python3.dll python.exe pythonw.exe python.pdb python35.pdb pythonw.pdb) do (
    copy /Y %SRC_DIR%\PCbuild\%%x %PREFIX%
    if errorlevel 1 exit 1
)

for %%x in (python35.lib python3.lib) do (
    copy /Y %SRC_DIR%\PCbuild\%%x %PREFIX%\libs\
    if errorlevel 1 exit 1
)

del %PREFIX%\libs\libpython*.a

set STDLIB_DIR=%PREFIX%\Lib
set SCRIPTS=%PREFIX%\Scripts

xcopy /s /y %SRC_DIR%\Lib %STDLIB_DIR%\
if errorlevel 1 exit 1

REM ========== bytecode compile standard library

rd /s /q %STDLIB_DIR%\lib2to3\tests\
if errorlevel 1 exit 1

%PREFIX%\python.exe -Wi %STDLIB_DIR%\compileall.py -f -q -x "bad_coding|badsyntax|py2_" %STDLIB_DIR%\
if errorlevel 1 exit 1

REM ========== add scripts

if not exist %SCRIPTS% (mkdir %SCRIPTS%)
if errorlevel 1 exit 1

for %%x in (idle pydoc) do (
    copy /Y %SRC_DIR%\Tools\scripts\%%x3 %SCRIPTS%\%%x
    if errorlevel 1 exit 1
)

copy /Y %SRC_DIR%\Tools\scripts\2to3 %SCRIPTS%
if errorlevel 1 exit 1

REM ========== generate grammar files for 2to3
%PREFIX%\python.exe %SCRIPTS%\2to3 -l
