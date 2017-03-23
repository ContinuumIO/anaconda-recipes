%PYTHON% -c "import cio_bt.check_vars"
if errorlevel 1 exit 1

%PYTHON% -c "import cio_bt.check_msvs"
if errorlevel 1 exit 1

%PYTHON% setup.py install
if errorlevel 1 exit 1
