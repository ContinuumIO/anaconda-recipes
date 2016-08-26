for %%x in (MySQLdb _mysql.pyd _mysql_exceptions.py MySQL_python-%PKG_VERSION%.dist-info) do (
    move %SRC_DIR%\%%x %SP_DIR%
    if errorlevel 1 exit 1
)
