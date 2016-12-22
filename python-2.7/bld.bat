REM ========== prepare source

if "%ARCH%"=="64" (
    set PLATFORM=x64
    set DMSW=-DMS_WIN64
    curl https://www.python.org/ftp/python/%PKG_VERSION%/python-%PKG_VERSION%.amd64-pdb.zip -o pdbs.zip
) else (
    set PLATFORM=Win32
    set DMSW=
    curl https://www.python.org/ftp/python/%PKG_VERSION%/python-%PKG_VERSION%-pdb.zip -o pdbs.zip
)

%SYS_PREFIX%\Scripts\replace.exe "@DMSW@" "%DMSW%" Lib\distutils\cygwinccompiler.py
if errorlevel 1 exit 1

REM ========== actual compile step

vcbuild PC\VS9.0\pcbuild.sln "Release|%PLATFORM%"

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
DEL python.pdb pythonw.pdb python27.pdb w9xpopen.pdb
popd
del pdbs.zip

REM ========== add stuff from our own build

if "%ARCH%"=="64" (
    set PCB=%SRC_DIR%\PC\VS9.0\amd64
) else (
    set PCB=%SRC_DIR%\PC\VS9.0
)

xcopy /s %SRC_DIR%\Include %PREFIX%\include\
if errorlevel 1 exit 1
copy %SRC_DIR%\PC\pyconfig.h %PREFIX%\include\
if errorlevel 1 exit 1

for %%x in (python27.dll python.exe pythonw.exe python.pdb python27.pdb pythonw.pdb) do (
    copy %PCB%\%%x %PREFIX%
    if errorlevel 1 exit 1
)
copy %PCB%\python27.lib %PREFIX%\libs\
if errorlevel 1 exit 1
del %PREFIX%\libs\libpython*.a
if errorlevel 1 exit 1

copy %PCB%\w9xpopen.exe %PREFIX%\
if errorlevel 1 exit 1

xcopy /s %SRC_DIR%\Lib %STDLIB_DIR%\
if errorlevel 1 exit 1
rd /s /q %PREFIX%\Lib\test
if errorlevel 1 exit 1
rd /s /q %PREFIX%\Lib\ensurepip
if errorlevel 1 exit 1

REM ========== bytecode compile standard library

%PYTHON% -Wi %STDLIB_DIR%\compileall.py -f -q -x "bad_coding|badsyntax|py3_" %STDLIB_DIR%
if errorlevel 1 exit 1

REM ========== add scripts

:: mkdir %SCRIPTS%
:: if errorlevel 1 exit 1
for %%x in (idle 2to3 pydoc) do (
    copy %SYS_PREFIX%\Lib\site-packages\conda_build\cli-%ARCH%.exe %SCRIPTS%\%%x.exe
    if errorlevel 1 exit 1
    copy %SRC_DIR%\Tools\scripts\%%x %SCRIPTS%\%%x-script.py
    if errorlevel 1 exit 1
    %SYS_PREFIX%\Scripts\replace.exe --nvd "#!" "#X" %SCRIPTS%\%%x-script.py
    if errorlevel 1 exit 1
)

REM ========== generate grammar files for 2to3
%PYTHON% %SCRIPTS%\2to3-script.py -l
