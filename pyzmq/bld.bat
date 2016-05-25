set DISTUTILS_USE_SDK=1

"%PYTHON%" setup.py configure --zmq bundled
if errorlevel 1 exit 1

"%PYTHON%" setup.py install
if errorlevel 1 exit 1

if "%PY_VER%" == "2.7" (
    del %SP_DIR%\zmq\asyncio.py
    del %SP_DIR%\zmq\auth\asyncio.py
    del %SP_DIR%\zmq\tests\_test_asyncio.py
)
