rd /s /q %SP_DIR%
move %SRC_DIR%\Lib\site-packages %STDLIB_DIR%
if errorlevel 1 exit 1
