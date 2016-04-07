@echo off
setlocal enabledelayedexpansion
REM This file should be run after installing the qt package into any
REM    environment.  It makes it so Qt knows where to look for includes and
REM    libs.  This script is copied in bld.bat to the post-link script for qt,
REM    which means it is run after the Qt package gets linked, and sets up
REM    the correct path for whatever Conda env you install Qt to.
pushd "%~dp0\..\"
set "FORWARD_SLASHED_PREFIX=%CD:\=/%"
if not exist "%CD%\Library" mkdir "%CD%\Library"
if not exist "%CD%\Library\bin" mkdir "%CD%\Library\bin"
echo [Paths] > "%CD%\Library\bin\qt.conf"
echo Prefix = %FORWARD_SLASHED_PREFIX%/Library >> "%CD%\Library\bin\qt.conf"
REM some things go looking in the prefix root (pyqt, for example)
COPY %CD%\Library\bin\qt.conf %CD%\qt.conf
@echo on
