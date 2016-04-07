nmake -f makefile.vc INSTDIR=%LIBRARY_PREFIX%
if errorlevel 1 exit 1

nmake -f makefile.vc INSTDIR=%LIBRARY_PREFIX% install-all
if errorlevel 1 exit 1
