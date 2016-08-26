@echo on
cd src\tools\msvc

echo $config-^>{openssl} = '%LIBRARY_PREFIX%'; >> config.pl
echo $config-^>{zlib} = '%LIBRARY_PREFIX%';    >> config.pl
echo $config-^>{python} = '%PREFIX%';          >> config.pl

:: Appveyor's postgres install is on PATH and interferes with testing
IF NOT "%APPVEYOR%" == "" (
    ECHO Deleting AppVeyor's PostgreSQL installs
    RD /S /Q "C:\Program Files\PostgreSQL"
)

if "%PY_VER%" == "2.7" goto :msbuildpath
if "%PY_VER%" == "3.4" goto :msbuildpath
goto :havemsbuild

:msbuildpath
  :: Need to move a more current msbuild into PATH.  32-bit one in particular on AppVeyor barfs on the solution that
  ::    Postgres writes here.  This one comes from the Win7 SDK (.net 4.0), and is known to work.
  set "PATH=%CD%;C:\Windows\Microsoft.NET\Framework\v4.0.30319;%PATH%"

:havemsbuild


if "%ARCH%" == "32" (
   set ARCH=Win32
) else (
   set ARCH=x64
)

perl mkvcbuild.pl
call msbuild %SRC_DIR%\pgsql.sln /p:Configuration=Release /p:Platform="%ARCH%" /m
if errorlevel 1 exit 1
call install.bat "%LIBRARY_PREFIX%"
if errorlevel 1 exit 1

echo Outputting versions: ctl, config, client
pg_ctl --version
pg_config --version
psql --version

REM On windows, it is necessary to start a server for the tests to connect to and run on
ECHO Creating data dir in C:\pgdata
mkdir C:\pgdata
:: Ensure that the work dir is writeable by the test process
icacls "c:\pgdata" /grant Everyone:(OI)(CI)F /T
"%LIBRARY_BIN%\initdb.exe" -D C:\pgdata
"%LIBRARY_BIN%\pg_ctl" -D "C:\pgdata" -l logfile start

call vcregress check
:: if errorlevel 1 call :done 1
call vcregress installcheck
:: if errorlevel 1 call :done 1
call vcregress plcheck
:: if errorlevel 1 call :done 1
call vcregress contribcheck
:: if errorlevel 1 call :done 1
call vcregress modulescheck
:: if errorlevel 1 call :done 1
call vcregress ecpgcheck
:: if errorlevel 1 call :done 1
call vcregress isolationcheck
:: if errorlevel 1 call :done 1
call vcregress upgradecheck
:: if errorlevel 1 call :done 1
:: This requires an extra perl module to run.  See
::    https://www.postgresql.org/docs/current/static/install-windows-full.html#AEN29138
:: call vcregress bincheck
:: if errorlevel 1 call :done 1

call :done 0

:done
  :: Kill any running server
  "%LIBRARY_BIN%\pg_ctl" stop -D C:\pgdata -m i
  :: clean up temporary database
  rd /s /q C:\pgdata

  :: make sure that all postgres server instances die
  taskkill /F /IM postgres.exe /T

  exit %~1
