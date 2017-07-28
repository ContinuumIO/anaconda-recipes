@echo off
setlocal enabledelayedexpansion
:: This file should be run after installing the qt package into any
:: environment.  It makes it so Qt knows where to look for includes and
:: libs.  This script is copied in bld.bat to the post-link script for qt,
:: which means it is run after the Qt package gets linked, and sets up
:: the correct path for whatever Conda env you install Qt to.
pushd "%~dp0\..\"
set "FORWARD_SLASHED_PREFIX=%CD:\=/%"
for /f "delims=" %%A in ('chcp') do set _TMP_CHCP_RESULT=%%A
for %%A in (%_TMP_CHCP_RESULT%) do set _TMP_OLD_CHCP=%%A
chcp 65001 > NUL
if not exist "%CD%\Library" mkdir "%CD%\Library"
if not exist "%CD%\Library\bin" mkdir "%CD%\Library\bin"
:: set byte order mark for outfile
>"%CD%\Library\bin\qt.conf" cmd.exe /c set /p "=﻿" <NUL
echo [Paths]>> "%CD%\Library\bin\qt.conf"
echo Prefix = %FORWARD_SLASHED_PREFIX%/Library>> "%CD%\Library\bin\qt.conf"
echo Binaries = %FORWARD_SLASHED_PREFIX%/Library/bin>> "%CD%\Library\bin\qt.conf"
echo Libraries = %FORWARD_SLASHED_PREFIX%/Library/lib>> "%CD%\Library\bin\qt.conf"
echo Headers = %FORWARD_SLASHED_PREFIX%/Library/include/qt>> "%CD%\Library\bin\qt.conf"
:: Some things go looking in the prefix root (pyqt, for example)
copy "%CD%\Library\bin\qt.conf" "%CD%\qt.conf"
chcp %_TMP_OLD_CHCP%
@echo on
