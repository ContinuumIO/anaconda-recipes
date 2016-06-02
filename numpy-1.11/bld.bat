echo # >> numpy\__init__.py
echo __mkl_version__ = '__MKL_VERSION__' >> numpy\__init__.py
if errorlevel 1 exit 1
%SCRIPTS%\mkl-version.exe numpy\__init__.py
if errorlevel 1 exit 1

copy %PREFIX%\cio_files\numpy\site-mkl-%SUBDIR%.cfg site.cfg
if errorlevel 1 exit 1

%SCRIPTS%\replace.exe @PREFIX@ %PREFIX% site.cfg
if errorlevel 1 exit 1

%PYTHON% setup.py install --old-and-unmanageable
if errorlevel 1 exit 1
