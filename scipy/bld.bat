set COMP_DIR=C:\Program Files (x86)\IntelSWTools\compilers_and_libraries\windows

set DISTUTILS_USE_SDK=1
set MSSdk=1

if %PY_VER%==3.5 (
    set "PY_VCRUNTIME_REDIST=%LIBRARY_BIN%\vcruntime140.dll"
    set VS=vs2015
) else (
    set VS=vs2010
)

if "%ARCH%"=="64" (
    set INTEL_ARCH=intel64
) else (
    set INTEL_ARCH=ia32
)
call "%COMP_DIR%\bin\ifortvars.bat" %INTEL_ARCH% %VS%
@rem Intel Fortran Compilers 2016 Update 3 remove support for vs2008.
@rem ifortvars.bat adds vs2010 (or vs2015) to front of PATH to affect
@rem this change. So we undo that here in a somewhat horrible manner.
if %VS_YEAR%==2008 (
    if "%ARCH%"=="64" (
        call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" amd64
    ) else (
        call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" x86
    )
)

@rem This *should* be MKLROOT (since that's what Intel use)
@rem See numpy PR: https://github.com/numpy/numpy/pull/7723
@rem The goal is to avoid using:
@rem envs/_build/lib/site-packages/numpy/distutils/site.cfg in which we get
@rem build-time baked paths, meaning if it was built on a different machine
@rem to the current one you're trying to build scipy on those paths may not
@rem exist.
set "MKL=%LIBRARY_PREFIX%"

%PYTHON% setup.py install
if errorlevel 1 exit 1
