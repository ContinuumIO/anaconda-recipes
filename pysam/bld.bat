copy %RECIPE_DIR%\stdint.h.win32 %SRC_DIR%\samtools\stdint.h
copy %RECIPE_DIR%\unistd.h.win32 %SRC_DIR%\samtools\unistd.h
copy %RECIPE_DIR%\Gamma.h %SRC_DIR%\samtools\
copy %RECIPE_DIR%\Gamma.cpp %SRC_DIR%\samtools\

set INCLUDE=%LIBRARY_INC%
%PYTHON% setup.py install
if errorlevel 1 exit 1
