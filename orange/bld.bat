move %SRC_DIR%\Orange %SP_DIR%
if errorlevel 1 exit 1

move %SRC_DIR%\Orange-%PKG_VERSION%.dist-info %SP_DIR%
if errorlevel 1 exit 1
