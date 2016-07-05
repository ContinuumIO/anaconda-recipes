REM ========== actual compile step

if "%ARCH%"=="64" (
   set PLATFORM=x64
   set VC_PATH=x64
) else (
   set PLATFORM=Win32
   set VC_PATH=x86
)

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

for %%x in (python35.dll python.exe pythonw.exe python.pdb python35.pdb pythonw.pdb) do (
    copy /Y %SRC_DIR%\PCbuild\%%x %PREFIX%
    if errorlevel 1 exit 1
)
copy /Y %SRC_DIR%\PCbuild\python35.lib %PREFIX%\libs\
if errorlevel 1 exit 1

del %PREFIX%\libs\libpython*.a

xcopy /s /y %SRC_DIR%\Lib %PREFIX%\Lib\
if errorlevel 1 exit 1

REM ========== bytecode compile standard library

rd /s /q %STDLIB_DIR%\lib2to3\tests\
if errorlevel 1 exit 1

%PYTHON% -Wi %STDLIB_DIR%\compileall.py -f -q -x "bad_coding|badsyntax|py2_" %STDLIB_DIR%
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
%PYTHON% %SCRIPTS%\2to3 -l
