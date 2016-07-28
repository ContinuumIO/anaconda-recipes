set TIFF_ROOT=%LIBRARY_PREFIX%
set JPEG_ROOT=%LIBRARY_PREFIX%
set ZLIB_ROOT=%LIBRARY_PREFIX%
set FREETYPE2_ROOT=%LIBRARY_PREFIX%
set LIB=%LIBRARY_LIB%;%LIB%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%

REM --old-and-unmanageable is a flag that disables egg installation.
REM    If you remove this, Pillow gets installed as an egg and the build
REM    system complains.
%PYTHON% setup.py build_ext install --old-and-unmanageable
if errorlevel 1 exit 1

rd /s /q %SP_DIR%\__pycache__
if errorlevel 1 exit 1
