if "%ARCH%"=="32" (
   set MACHINE="IX86"
) else (
  set MACHINE="AMD64"
)

curl -L -o tcl%PKG_VERSION%.tar.gz "http://sourceforge.net/projects/tcl/files/Tcl/%PKG_VERSION%/tcl%PKG_VERSION%-src.tar.gz/download"
curl -L -o tk%PKG_VERSION%.tar.gz "http://sourceforge.net/projects/tcl/files/Tcl/%PKG_VERSION%/tk%PKG_VERSION%-src.tar.gz/download"

7za x -so tcl%PKG_VERSION%.tar.gz | 7za x -si -aoa -ttar
7za x -so tk%PKG_VERSION%.tar.gz | 7za x -si -aoa -ttar

cd tcl%PKG_VERSION%\win
nmake -f makefile.vc all install INSTALLDIR=%LIBRARY_PREFIX% MACHINE=%MACHINE%
if %ERRORLEVEL% GTR 0 exit 1

REM Required for having tmschema.h accessible.  Newer VS versions do not include this.
REM If you don't have this path, you are missing the Windows 7 SDK.  Please install this.
REM   NOTE: Later SDKs remove tmschema.h.  It really is necessary to use the Win 7 SDK.
set INCLUDE=%INCLUDE%;c:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include


cd ..\..\tk%PKG_VERSION%\win
nmake -f makefile.vc all install INSTALLDIR=%LIBRARY_PREFIX% MACHINE=%MACHINE% TCLDIR=..\..\tcl%PKG_VERSION%
if %ERRORLEVEL% GTR 0 exit 1
