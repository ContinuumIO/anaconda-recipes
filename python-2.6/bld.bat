REM ========== prepare source

if "%ARCH%"=="64" (
    set DMSW=-DMS_WIN64
) else (
    set DMSW=
)

%REPLACE% "@DMSW@" "%DMSW%" Lib\distutils\cygwinccompiler.py
if errorlevel 1 exit 1

REM ========== actual compile step

vcbuild PCbuild\pcbuild.sln "%RELEASE_TARGET%"

if "%ARCH%"=="64" (
    copy PCbuild\amd64\* PCbuild\
    if errorlevel 1 exit 1
)

REM ========== add stuff from official python.org msi

set MSI_DIR=\Pythons\2.6.6-%ARCH%
for %%x in (DLLs Doc libs tcl Tools) do (
    xcopy /s %MSI_DIR%\%%x %PREFIX%\%%x\
    if errorlevel 1 exit 1
)

REM ========== add stuff from our own build

set PCB=%SRC_DIR%\PCbuild

xcopy /s %SRC_DIR%\Include %PREFIX%\include\
if errorlevel 1 exit 1
copy %SRC_DIR%\PC\pyconfig.h %PREFIX%\include\
if errorlevel 1 exit 1

for %%x in (python26.dll python.exe pythonw.exe) do (
    copy %PCB%\%%x %PREFIX%
    if errorlevel 1 exit 1
)
copy %PCB%\python26.lib %PREFIX%\libs\
if errorlevel 1 exit 1
del %PREFIX%\libs\libpython*.a

copy %PCB%\w9xpopen.exe %PREFIX%\
if errorlevel 1 exit 1

xcopy /s %SRC_DIR%\Lib %PREFIX%\Lib\
if errorlevel 1 exit 1

REM ========== bytecode compile standard library

rd /s /q %STDLIB_DIR%\lib2to3\tests\

%PYTHON% -Wi %STDLIB_DIR%\compileall.py -f -q -x "bad_coding|badsyntax|py3_" %STDLIB_DIR%
if errorlevel 1 exit 1

REM ========== add scripts

mkdir %SCRIPTS%
if errorlevel 1 exit 1
for %%x in (2to3 pydoc) do (
    copy %SRC_DIR%\Tools\scripts\%%x %SCRIPTS%
    if errorlevel 1 exit 1
)

REM ========== generate grammar files for 2to3
%PYTHON% %SCRIPTS%\2to3 -l
