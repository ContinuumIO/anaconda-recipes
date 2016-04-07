set KRB5_SRC=%SRC_DIR%/src
set KRB_INSTALL_DIR=%LIBRARY_PREFIX%

cd %KRB5_SRC%

nmake -f Makefile.in prep-windows
nmake NODEBUG=1
nmake install NODEBUG=1
