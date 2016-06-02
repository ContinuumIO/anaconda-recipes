%PYTHON% setup.py install
if errorlevel 1 exit 1

REM    %REPLACE% "distutils.core" "setuptools" setup.py
REM    if errorlevel 1 exit 1
REM
REM    set CONDA_BUILD=
REM    easy_install wheel
REM    if errorlevel 1 exit 1
REM
REM    python setup.py bdist_wheel
REM    if errorlevel 1 exit 1
REM
REM    move dist\pycosat-*.whl C:\wheels
REM    echo "==========================================="
REM    echo "Please find the wheel package in C:\wheels"
REM    echo "==========================================="
REM    exit 1
