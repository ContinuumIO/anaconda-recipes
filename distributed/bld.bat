"%PYTHON%" setup.py install --old-and-unmanageable
if errorlevel 1 exit 1

cd %SCRIPTS%
del dcenter* dcluster* dscheduler* dworker*
