move %SRC_DIR%\lxml %SP_DIR%
if errorlevel 1 exit 1

move %SRC_DIR%\lxml-%PKG_VERSION%.dist-info %SP_DIR%
if errorlevel 1 exit 1
