cd %SRC_DIR%

set "URL=http://downloads.sourceforge.net/project/gnuwin32/"
if errorlevel 1 exit 1

set "FILES=coreutils-5.3.0-bin.zip coreutils-5.3.0-dep.zip util-linux-ng-2.14.1-dep.zip ascii_chart-0.9-bin.zip ascii_chart-0.9-dep.zip util-linux-ng-2.14.1-bin.zip m4-1.4.12-lib.zip m4-1.4.14-1-bin.zip m4-1.4.14-1-dep.zip sed-4.2.1-bin.zip sed-4.2.1-dep.zip"

set "URLS=coreutils/5.3.0/coreutils-5.3.0-bin.zip coreutils/5.3.0/coreutils-5.3.0-dep.zip util-linux/2.14.1/util-linux-ng-2.14.1-dep.zip ascii_chart/0.9/ascii_chart-0.9-bin.zip ascii_chart/0.9/ascii_chart-0.9-dep.zip util-linux/2.14.1/util-linux-ng-2.14.1-bin.zip m4/1.4.12/m4-1.4.12-lib.zip m4/1.4.14-1/m4-1.4.14-1-bin.zip m4/1.4.14-1/m4-1.4.14-1-dep.zip sed/4.2.1/sed-4.2.1-bin.zip sed/4.2.1/sed-4.2.1-dep.zip"

FOR %%A IN (%URLS%) DO (
  wget -c %URL%/%%A
)
if errorlevel 1 exit 1


FOR %%A IN (%FILES%) DO (
  unzip -n %%A -d %LIBRARY_PREFIX%
)
if errorlevel 1 exit 1

cd %LIBRARY_PREFIX%
rm -rf contrib share manifest man

