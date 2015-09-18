cd %SRC_DIR%
set ROOT_URL="http://iweb.dl.sourceforge.net/project/gnuwin3"

FOR %%A IN (coreutils-5.3.0-bin.zip,
           coreutils-5.3.0-dep.zip,
           util-linux-ng-2.14.1-dep.zip,
           ascii_chart-0.9-bin.zip,
           ascii_chart-0.9-dep.zip,
           util-linux-ng-2.14.1-bin.zip,
           m4-1.4.12-lib.zip,
           m4-1.4.14-1-bin.zip,
           m4-1.4.14-1-dep.zip,
           sed-4.2.1-bin.zip,
           sed-4.2.1-dep.zip)
DO (
  wget -c %ROOT_URL%/%A%
)


