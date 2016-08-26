for %%x in (cffi cffi-%PKG_VERSION%.dist-info) do (
    move %SRC_DIR%\%%x %SP_DIR%
    if errorlevel 1 exit 1
)
for /f %%x in ('dir /b *.pyd') do move %%x %SP_DIR%\
