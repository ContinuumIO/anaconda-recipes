REM ========== prepare source

if "%ARCH%"=="64" (
    set DMSW=-DMS_WIN64
    set PCB=%SRC_DIR%\PCbuild\amd64
    curl https://www.python.org/ftp/python/%PKG_VERSION%/python-%PKG_VERSION%.amd64-pdb.zip -o pdbs.zip
) else (
    set DMSW=
    set PCB=%SRC_DIR%\PCbuild
    curl https://www.python.org/ftp/python/%PKG_VERSION%/python-%PKG_VERSION%.amd64-pdb.zip -o pdbs.zip
)

%SYS_PREFIX%\Scripts\replace.exe "@DMSW@" "%DMSW%" Lib\distutils\cygwinccompiler.py
if errorlevel 1 exit 1

REM ========== actual compile step

msbuild PCbuild\pcbuild.sln /t:build /p:Configuration=Release

REM ========== add stuff from official python.org msi

set MSI_DIR=\Pythons\%PKG_VERSION%-%ARCH%
for %%x in (DLLs Doc libs tcl Tools) do (
    xcopy /s %MSI_DIR%\%%x %PREFIX%\%%x\
    if errorlevel 1 exit 1
)

REM ========== add pdbs from official download

pushd %PREFIX%\DLLs
7za.exe x %SRC_DIR%\pdbs.zip
if errorlevel 1 exit 1
DEL python.pdb pythonw.pdb python34.pdb w9xpopen.pdb
popd
del pdbs.zip

REM ========== add stuff from our own build

xcopy /s %SRC_DIR%\Include %PREFIX%\include\
if errorlevel 1 exit 1
copy %SRC_DIR%\PC\pyconfig.h %PREFIX%\include\
if errorlevel 1 exit 1

for %%x in (python34.dll python.exe pythonw.exe python.pdb python34.pdb pythonw.pdb) do (
    copy %PCB%\%%x %PREFIX%
    if errorlevel 1 exit 1
)
copy %PCB%\python34.lib %PREFIX%\libs\
if errorlevel 1 exit 1
del %PREFIX%\libs\libpython*.a

xcopy /s %SRC_DIR%\Lib %PREFIX%\Lib\
if errorlevel 1 exit 1

REM ========== bytecode compile standard library

rd /s /q %STDLIB_DIR%\lib2to3\tests\
if errorlevel 1 exit 1

%PYTHON% -Wi %STDLIB_DIR%\compileall.py -f -q -x "bad_coding|badsyntax|py2_" %STDLIB_DIR%
if errorlevel 1 exit 1

REM ========== add scripts

mkdir %SCRIPTS%
if errorlevel 1 exit 1

for %%x in (idle pydoc) do (
    copy %SRC_DIR%\Tools\scripts\%%x3 %SCRIPTS%\%%x
    if errorlevel 1 exit 1
)

copy %SRC_DIR%\Tools\scripts\2to3 %SCRIPTS%
if errorlevel 1 exit 1

REM ========== generate grammar files for 2to3
%PYTHON% %SCRIPTS%\2to3 -l
