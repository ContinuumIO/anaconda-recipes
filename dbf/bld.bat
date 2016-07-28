pushd dbf
del ver_32.py
if %PY3K%==1 (
    del ver_2.py
) else (
    del ver_33.py
)
popd

%PYTHON% setup.py install
if errorlevel 1 exit 1
