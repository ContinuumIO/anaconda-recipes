set STATIC=%SP_DIR%\IPython\html\static

mkdir %STATIC%
if errorlevel 1 exit 1

xcopy /s %SRC_DIR% %STATIC%\mathjax\
REM if errirlevel 1 exit 1
