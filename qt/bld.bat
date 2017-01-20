@echo on
setlocal EnableDelayedExpansion
set QMAKESPEC=win32-msvc%VS_YEAR%
set SHORT_VERSION=%PKG_VERSION:~0,-2%

:: conda-forge/obviousci's obvci_appveyor_python_build_env.cmd used
:: so we shouldn't include it finally.  I use it to set the correct
:: Windows SDK, but conda-build should take care of that probably??
:: It requires TARGET_ARCH to be one of x64 or x86.  On conda-forge
:: this script is run *before* bld.bat.
if "%ARCH%" == "64" (
  set TARGET_ARCH=x64
) else (
  set TARGET_ARCH=x86
)
call %RECIPE_DIR%\obvci_appveyor_python_build_env.cmd

if "%DXSDK_DIR%" == "" (
  echo You do not appear to have the DirectX SDK installed.  Please get it from
  echo    https://www.microsoft.com/en-us/download/details.aspx?id=6812
  echo and try this build again.  If you have installed it, and are still seeing
  echo this message, please open a new console to refresh your environment variables.
  exit /b 1
)

:: Webengine requires either working OpenGL drivers or
:: Angle (therefore DirectX >= 11). This works on some
:: VMs and not others.  Windows 7 VirtualBox instantly
:: aborts when loading Spyder sSo we've had to disable
:: it globally.
:: Using Mesa from MSYS2 is mentioned as a workaround:
::  http://wiki.qt.io/Cross-compiling-Mesa-for-Windows
:: `set QT_OPENGL=software` forces Qt5 to use that but
:: but when I tried it it was too buggy; Spyder crashed a
:: little bit later, though it worked for Carlos.
set AVOID_WEBENGINE=yes
set WEBBACKEND=qtwebengine
if %VS_MAJOR% LSS 14 (
  set WEBBACKEND=qtwebkit
)
if "%AVOID_WEBENGINE%" == "yes" (
  set WEBBACKEND=qtwebkit
)


if "%DIRTY%" == "" (
  if "%WEBBACKEND%" == "qtwebkit" (
    curl -LO "http://download.qt.io/community_releases/%SHORT_VERSION%/%PKG_VERSION%/qtwebkit-opensource-src-%PKG_VERSION%.tar.xz"
    if errorlevel 1 exit 1
    7za x -so qtwebkit-opensource-src-%PKG_VERSION%.tar.xz | 7za x -si -aoa -ttar > NUL 2>&1
    if errorlevel 1 exit 1
    move qtwebkit-opensource-src-%PKG_VERSION% qtwebkit
  )
)

:: Shortening the build path is no longer necessary since
:: conda-build has the `--croot PATH` and `--no-build-id` options,
:: but the code is left here for people using an older conda-build.
:: Shorten our build path as much as possible
:: set _BLDTMP=C:\qt5-%ARCH%-%CONDA_PY%

if DEFINED _BLDTMP (
  if "%DIRTY%" == "" (
    if exist "%_BLDTMP%" (
      rmdir /s /q "%_BLDTMP%"
    )
    mkdir "%_BLDTMP%"
    :: Copy all files except bld.bat, which needs to stay in place while script runs
    robocopy %SRC_DIR%\ %_BLDTMP%\ *.* /E /NFL /NDL /xf bld.bat
  )
  pushd "%_BLDTMP%"
)

:: set path to find resources shipped with qt-5 (Ruby comes from upstream MSYS2 for now, PATH set externally!)
:: see http://doc-snapshot.qt-project.org/qt5-5.4/windows-building.html
set "PATH=%CD%\qtbase\bin;%CD%\gnuwin32\bin;C:\StrawberryPerl%ARCH%\perl\bin;%PATH%"

where ruby.exe
if %ERRORLEVEL% neq 0 (
  echo Could not find ruby.exe
  exit /b 1
)

where perl.exe
if %ERRORLEVEL% neq 0 (
  echo Could not find perl.exe
  exit /b 1
)


:: Install a custom python 27 environment for us, to use in building webengine, but avoid feature activation
:: At present (5th July 2016) calling `conda create -y -n python27_qt5_build python=2.7` causes the build to
:: fail immediately after, so I'm bodging around that by not doing it if it exists.  This means you must run
:: the builds twice. Sorry. Time is not on my side here.
if "%WEBBACKEND%" == "qtwebengine" (
  if not exist %SYS_PREFIX%\envs\python27_qt5_build (
    conda create -y -n python27_qt5_build python=2.7
  )
  set "PATH=%SYS_PREFIX%\envs\python27_qt5_build;%SYS_PREFIX%\envs\python27_qt5_build\Scripts;%SYS_PREFIX%\envs\python27_qt5_build\Library\bin;%PATH%"
)

:: make sure we can find ICU and openssl:
set "INCLUDE=%LIBRARY_INC%;%INCLUDE%"
set "LIB=%LIBRARY_LIB%;%LIB%"

:: WebEngine (Chromium) specific definitions.  Only build this with VS 2015 (no support for python < 3.5)
if "%WEBBACKEND%" == "qtwebengine" (
  set "WSDK8=C:\\Program\ Files\ (x86)\\Windows\ Kits\\8.1"
  set "WDK=C:\\WinDDK\\7600.16385.1"
  set "INCLUDE=%WSDK8%\Include;%WDK%\inc;%INCLUDE%"
  if "%ARCH%"=="32" (
    set "PATH=%WSDK8%\bin\x86;%WDK$%\bin\x86;%PATH%"
    set "LIB=%LIB%;%WSDK8%\Lib\winv6.3\um\x86"
  ) else (
    set "PATH=%WSDK8%\bin\x64;%WDK$%\bin\amd64;%PATH%"
    set "LIB=%LIB%;%WSDK8%\Lib\winv6.3\um\x64"
  )
  set "GYP_DEFINES=windows_sdk_path='%WSDK8%'"
  set GYP_MSVS_VERSION=2015
  set GYP_GENERATORS=ninja
  set GYP_PARALLEL=1
  set "WDK_DIR=%WDK%"
  set "WindowsSDKDir=%WSDK8%"
) else (
  rmdir /s /q qtwebengine
)

:: Angle requires C++11 compilers so vc9 Qt5 must only use DesktopGL
:: QT_OPENGL=software *may* work too given non-broken opengl32sw.dll
if %VS_MAJOR% LSS 10 (
  set OPENGLVER=desktop
) else (
  set OPENGLVER=dynamic
)

:: Make sure we can find sqlite3:
set SQLITE3SRCDIR=%CD%\qtbase\src\3rdparty\sqlite

:: Patch does not apply cleanly.  Copy file.
:: https://codereview.qt-project.org/#/c/141019/
copy %RECIPE_DIR%\tst_compiler.cpp qtbase\tests\auto\other\compiler\

:: A check here. We need to add msinttypes to defaults.
if %VS_MAJOR% LSS 10 (
  if not exist %PREFIX%/Library/include/stdint.h (
    echo %PREFIX%/include/stdint.h does not exist, please use msinttypes
    exit /b 1
  )
)

goto SKIP_REBUILD_CONFIGURE_EXE
:: If applying 0009-Win32-Re-permit-fontconfig-and-qt-freetype.patch (or
:: any patch that changes configureapp.cpp or any of the bootstrap files
:: in any way that alters the configure result) then configure.exe needs
:: to be rebuilt. Here I duplicate logic from configure.bat because that
:: file conflates needing to rebuild configure.exe with using a git repo
:: clone (OK, we should really remove that conflation instead and always
:: just rebuild configure.exe).
pushd qtbase
del /q configure.exe
set QTSRC=%CD%\
pushd tools\configure
set make=jom
set QTVERSION=%PKG_VERSION%
for /f "tokens=1,2,3,4 delims=.= " %%i in ('echo Qt.%QTVERSION%') do (
    set QTVERMAJ=%%j
    set QTVERMIN=%%k
    set QTVERPAT=%%l
)
:: .. end of specifically this bit is untested
echo #### Generated by configure.bat - DO NOT EDIT! ####> Makefile
echo/>> Makefile
set 
echo QTVERSION = %QTVERSION%>> Makefile
rem These must have trailing spaces to avoid misinterpretation as 5>>, etc.
echo QT_VERSION_MAJOR = %QTVERMAJ% >> Makefile
echo QT_VERSION_MINOR = %QTVERMIN% >> Makefile
echo QT_VERSION_PATCH = %QTVERPAT% >> Makefile
echo CXX = cl>>Makefile
echo EXTRA_CXXFLAGS =>>Makefile
rem This must have a trailing space.
echo QTSRC = %QTSRC% >> Makefile
set tmpl=win32
echo/>> Makefile
type Makefile.%tmpl% >> Makefile
%make%
popd
popd
:SKIP_REBUILD_CONFIGURE_EXE

:: See http://doc-snapshot.qt-project.org/qt5-5.4/windows-requirements.html
:: this needs to be CALLed due to an exit statement at the end of configure:
call configure ^
     -prefix %LIBRARY_PREFIX% ^
     -libdir %LIBRARY_LIB% ^
     -bindir %LIBRARY_BIN% ^
     -headerdir %LIBRARY_INC%\qt ^
     -archdatadir %LIBRARY_PREFIX% ^
     -datadir %LIBRARY_PREFIX% ^
     -L %LIBRARY_LIB% ^
     -I %LIBRARY_INC% ^
     -confirm-license ^
     -no-fontconfig ^
     -icu ^
     -no-separate-debug-info ^
     -no-warnings-are-errors ^
     -nomake examples ^
     -nomake tests ^
     -no-warnings-are-errors ^
     -opengl %OPENGLVER% ^
     -opensource ^
     -openssl ^
     -platform win32-msvc%VS_YEAR% ^
     -release ^
     -shared ^
     -qt-freetype ^
     -system-libjpeg ^
     -system-libpng ^
     -system-zlib

:: To get a much quicker turnaround you can add this: (remember also to add the hat symbol after -system-zlib)
:: -skip %WEBBACKEND% -skip qtwebsockets -skip qtwebchannel -skip qtwayland -skip qtwinextras -skip qtsvg -skip qtsensors -skip qtcanvas3d -skip qtconnectivity -skip declarative -skip multimedia -skip qttools

:: jom is nmake alternative with multicore support, uses all cores by default
jom -U release
if errorlevel 1 exit /b 1
echo Finished `jom -U release`
jom -U install
if errorlevel 1 exit /b 1
echo Finished `jom -U install`

:: See above. At present `conda remove` also causes immediate build failure.
rem if "%WEBBACKEND%" == "qtwebengine" (
rem   conda remove -y -n python27_qt5_build --all
rem )

if DEFINED _BLDTMP (
  %PYTHON% %RECIPE_DIR%\patch_prefix_files.py "%_BLDTMP%"
  popd
)

:: To rewrite qt.conf contents per conda environment
copy "%RECIPE_DIR%\write_qtconf.bat" "%PREFIX%\Scripts\.qt-post-link.bat"

