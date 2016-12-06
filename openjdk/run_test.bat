IF NOT EXIST "%PREFIX%\etc\conda\activate.d\java_home.bat" exit 1
IF NOT EXIST "%PREFIX%\etc\conda\deactivate.d\java_home.bat" exit 1
IF NOT "%JAVA_HOME%" == "%PREFIX%\Library" exit 1
