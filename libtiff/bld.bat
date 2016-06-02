nmake /f makefile.vc clean
if errorlevel 1 exit 1
nmake /f makefile.vc
if errorlevel 1 exit 1

REM Install step
copy libtiff\libtiff.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1
copy libtiff\libtiff.lib %LIBRARY_LIB%\tiff.lib
if errorlevel 1 exit 1
copy libtiff\libtiff.dll %LIBRARY_BIN%\
if errorlevel 1 exit 1
copy libtiff\libtiff_i.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1
xcopy libtiff\*.h %LIBRARY_INC%\
if errorlevel 1 exit 1
