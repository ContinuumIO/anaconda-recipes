REM Configure step
copy jconfig.vc jconfig.h
if errorlevel 1 exit 1

REM Required for having win32.mak accessible.  Newer VS versions do not include this.
REM If you don't have this path, you are missing the Windows 7 SDK.  Please install this.
REM   NOTE: Later SDKs remove win32.mak.  It really is necessary to use the Win 7 SDK.
set INCLUDE=%INCLUDE%;c:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include

REM Build step
nmake /f makefile.vc nodebug=1
if errorlevel 1 exit 1

REM Install step
copy libjpeg.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1
copy libjpeg.lib %LIBRARY_LIB%\jpeg.lib
if errorlevel 1 exit 1
copy jpeglib.h %LIBRARY_INC%\
if errorlevel 1 exit 1
copy jconfig.h %LIBRARY_INC%\
if errorlevel 1 exit 1
copy jmorecfg.h %LIBRARY_INC%\
if errorlevel 1 exit 1
copy jerror.h %LIBRARY_INC%\
if errorlevel 1 exit 1
copy jpegint.h %LIBRARY_INC%\
if errorlevel 1 exit 1
