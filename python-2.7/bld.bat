set HOST_PYTHON=%PYTHON%
cmd /c Tools\buildbot\external-common.bat

if "%ARCH%" == "64" (
    set PLATF=x64
    set MACHINE=AMD64
) else (
    set PLATF=Win32
    set MACHINE=IX86
)


REM ========== build external deps
cd %SRC_DIR%\externals
if not exist tcltk\bin\tcl85.dll (
    @rem all and install need to be separate invocations, otherwise nmakehlp is not found on install
    cd tcl-8.5.15.0\win
    nmake -f makefile.vc MACHINE=%MACHINE% INSTALLDIR=..\..\tcltk clean all
    nmake -f makefile.vc MACHINE=%MACHINE% INSTALLDIR=..\..\tcltk install
    cd ..\..
)

if not exist tcltk\bin\tk85.dll (
    cd tk-8.5.15.0\win
    nmake -f makefile.vc MACHINE=%MACHINE% INSTALLDIR=..\..\tcltk TCLDIR=..\..\tcl-8.5.15.0 clean
    nmake -f makefile.vc MACHINE=%MACHINE% INSTALLDIR=..\..\tcltk TCLDIR=..\..\tcl-8.5.15.0 all
    nmake -f makefile.vc MACHINE=%MACHINE% INSTALLDIR=..\..\tcltk TCLDIR=..\..\tcl-8.5.15.0 install
    cd ..\..
)

if not exist tcltk\lib\tix8.4.3\tix84.dll (
    cd tix-8.4.3.5\win
    nmake -f python.mak MACHINE=%MACHINE% TCL_DIR=..\..\tcl-8.5.15.0 TK_DIR=..\..\tk-8.5.15.0 INSTALL_DIR=..\..\tcltk clean
    nmake -f python.mak MACHINE=%MACHINE% TCL_DIR=..\..\tcl-8.5.15.0 TK_DIR=..\..\tk-8.5.15.0 INSTALL_DIR=..\..\tcltk all
    nmake -f python.mak MACHINE=%MACHINE% TCL_DIR=..\..\tcl-8.5.15.0 TK_DIR=..\..\tk-8.5.15.0 INSTALL_DIR=..\..\tcltk install
    cd ..\..
)


REM ========== actual compile step
cd %SRC_DIR%
vcbuild PCbuild\pcbuild.sln "Release|%PLATF%"

if "%ARCH%"=="64" (
    copy PCbuild\amd64\* PCbuild\
    if errorlevel 1 exit 1
)

REM ========== add stuff from official python.org msi

set MSI_DIR=\Pythons\2.7.10-%ARCH%
for %%x in (DLLs Doc libs tcl Tools) do (
    xcopy /s %MSI_DIR%\%%x %PREFIX%\%%x\
    if errorlevel 1 exit 1
)
copy %MSI_DIR%\LICENSE.txt %PREFIX%\LICENSE_PYTHON.txt
if errorlevel 1 exit 1

REM ========== add stuff from our own build

set PCB=%SRC_DIR%\PCbuild

xcopy /s %SRC_DIR%\Include %PREFIX%\include\
if errorlevel 1 exit 1
copy %SRC_DIR%\PC\pyconfig.h %PREFIX%\include\
if errorlevel 1 exit 1

for %%x in (python27.dll python.exe pythonw.exe) do (
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

REM ========== bytecode compile standard library

%PYTHON% -Wi %STDLIB_DIR%\compileall.py -f -q -x "bad_coding|badsyntax|py3_" %STDLIB_DIR%
if errorlevel 1 exit 1

REM ========== add scripts

mkdir %SCRIPTS%
if errorlevel 1 exit 1
for %%x in (idle 2to3 pydoc) do (
    copy %SRC_DIR%\Tools\scripts\%%x %SCRIPTS%
    if errorlevel 1 exit 1
)
