REM Build step
nmake -f Makefile.nmake
if errorlevel 1 exit 1

REM Install step
mkdir %LIBRARY_INC%\event2
copy libevent.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1
copy libevent_extras.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1
copy libevent_core.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1
xcopy /s include\event2\*.* %LIBRARY_INC%\event2\
if errorlevel 1 exit 1

mkdir %PREFIX%\libevent
xcopy /s *.*  %PREFIX%\libevent\
if errorlevel 1 exit 1
