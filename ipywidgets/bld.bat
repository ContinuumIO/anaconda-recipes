%PYTHON% setup.py install
if errorlevel 1 exit 1

:: ipywidgets
jupyter-nbextension enable widgetsnbextension --py --sys-prefix
if errorlevel 1 exit 1

if %PY3K%==1 (
    rd /s /q %SP_DIR%\__pycache__
)
