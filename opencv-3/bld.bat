@echo ON
setlocal enabledelayedexpansion

curl -L -O "https://github.com/opencv/opencv_contrib/archive/%PKG_VERSION%.tar.gz"
%PYTHON% -c "import tarfile, os; tar = tarfile.open(os.environ['PKG_VERSION'] + '.tar.gz', 'r:gz'); tar.extractall(); tar.close()"
%PYTHON% -c "import hashlib, os; print(hashlib.sha256(open(os.environ['PKG_VERSION'] + '.tar.gz', 'rb').read()).hexdigest())" > sha256.out
SET /p CONTRIB_SHA256=<sha256.out
if NOT "%CONTRIB_SHA256%" == "ef2084bcd4c3812eb53c21fa81477d800e8ce8075b68d9dedec90fef395156e5" (
    exit 1
)

rem Patches apply only to opencv_contrib so we have to apply them now (after source download above)
rem Fixed: https://github.com/opencv/opencv_contrib/blob/6cd8e9f556c8c55c05178dec05d5277ae00020d9/modules/tracking/src/trackerKCF.cpp#L669
git apply --whitespace=fix -p0 "%RECIPE_DIR%\kcftracker.patch"
rem Fixed: https://github.com/opencv/opencv_contrib/blob/master/modules/text/src/ocr_beamsearch_decoder.cpp#L569
git apply --whitespace=fix -p0 "%RECIPE_DIR%\ocr_beamsearch_decoder.patch"
rem Fixed: https://github.com/opencv/opencv_contrib/blob/master/modules/text/src/ocr_hmm_decoder.cpp#L985
git apply --whitespace=fix -p0 "%RECIPE_DIR%\ocr_hmm_decoder.patch"
rem Fixed: https://github.com/opencv/opencv_contrib/blob/master/modules/dpm/src/dpm_nms.cpp#L43
git apply --whitespace=fix -p0 "%RECIPE_DIR%\dpm.patch"

mkdir build
cd build

if "%PY3K%" == "0" (
    echo "Copying stdint.h for windows"
    copy "%LIBRARY_INC%\stdint.h" %SRC_DIR%\modules\calib3d\include\stdint.h
    copy "%LIBRARY_INC%\stdint.h" %SRC_DIR%\modules\videoio\include\stdint.h
    copy "%LIBRARY_INC%\stdint.h" %SRC_DIR%\modules\highgui\include\stdint.h
)

for /F "tokens=1,2 delims=. " %%a in ("%PY_VER%") do (
   set "PY_MAJOR=%%a"
   set "PY_MINOR=%%b"
)
set PY_LIB=python%PY_MAJOR%%PY_MINOR%.lib


:: CMake/OpenCV like Unix-style paths for some reason.
set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%


cmake .. -LAH -G "NMake Makefiles"                                                  ^
    -DWITH_EIGEN=1                                                                  ^
    -DBUILD_TESTS=0                                                                 ^
    -DBUILD_DOCS=0                                                                  ^
    -DBUILD_PERF_TESTS=0                                                            ^
    -DBUILD_ZLIB=0                                                                  ^
    -DBUILD_opencv_bioinspired=0                                                    ^
    -DBUILD_TIFF=0                                                                  ^
    -DBUILD_PNG=0                                                                   ^
    -DBUILD_OPENEXR=1                                                               ^
    -DBUILD_JPEG=0                                                                  ^
    -DWITH_CUDA=0                                                                   ^
    -DWITH_OPENCL=0                                                                 ^
    -DWITH_OPENNI=0                                                                 ^
    -DWITH_FFMPEG=0                                                                 ^
    -DWITH_VTK=0                                                                    ^
    -DINSTALL_C_EXAMPLES=0                                                          ^
    -DOPENCV_EXTRA_MODULES_PATH=%UNIX_SRC_DIR%/opencv_contrib-%PKG_VERSION%/modules ^
    -DCMAKE_BUILD_TYPE="Release"                                                    ^
    -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX%                                    ^
    -DEXECUTABLE_OUTPUT_PATH=%UNIX_LIBRARY_BIN%                                     ^
    -DLIBRARY_OUTPUT_PATH=%UNIX_LIBRARY_BIN%                                        ^
    -DPYTHON_EXECUTABLE=""                                                          ^
    -DPYTHON_INCLUDE_DIR=""                                                         ^
    -DPYTHON_PACKAGES_PATH=""                                                       ^
    -DPYTHON_LIBRARY=""                                                             ^
    -DPYTHON_NUMPY_INCLUDE_DIRS=""                                                  ^
    -DBUILD_opencv_python2=0                                                        ^
    -DPYTHON2_EXECUTABLE=""                                                         ^
    -DPYTHON2_INCLUDE_DIR=""                                                        ^
    -DPYTHON2_NUMPY_INCLUDE_DIRS=""                                                 ^
    -DPYTHON2_LIBRARY=""                                                            ^
    -DPYTHON2_PACKAGES_PATH=""                                                      ^
    -DBUILD_opencv_python3=0                                                        ^
    -DPYTHON3_EXECUTABLE=""                                                         ^
    -DPYTHON3_INCLUDE_DIR=""                                                        ^
    -DPYTHON3_NUMPY_INCLUDE_DIRS=""                                                 ^
    -DPYTHON3_LIBRARY=""                                                            ^
    -DPYTHON3_PACKAGES_PATH=""
if errorlevel 1 exit 1

cmake .. -LAH -G "NMake Makefiles"                                                  ^
    -DPYTHON_EXECUTABLE=%UNIX_PREFIX%/python                                        ^
    -DPYTHON_INCLUDE_DIR=%UNIX_PREFIX%/include                                      ^
    -DPYTHON_PACKAGES_PATH=%UNIX_SP_DIR%                                            ^
    -DPYTHON_LIBRARY=%UNIX_PREFIX%/libs/%PY_LIB%                                    ^
    -DPYTHON_NUMPY_INCLUDE_DIRS=%UNIX_SP_DIR%/numpy/core/include                    ^
    -DBUILD_opencv_python%PY_MAJOR%=1                                               ^
    -DPYTHON%PY_MAJOR%_EXECUTABLE=%UNIX_PREFIX%/python                              ^
    -DPYTHON%PY_MAJOR%_INCLUDE_DIR=%UNIX_PREFIX%/include                            ^
    -DPYTHON%PY_MAJOR%_NUMPY_INCLUDE_DIRS=%UNIX_SP_DIR%/numpy/core/include          ^
    -DPYTHON%PY_MAJOR%_LIBRARY=%UNIX_PREFIX%/libs/%PY_LIB%                          ^
    -DPYTHON%PY_MAJOR%_PACKAGES_PATH=%UNIX_SP_DIR%
if errorlevel 1 exit 1

cmake --build . --target INSTALL --config Release
if errorlevel 1 exit 1

if "%ARCH%" == "32" ( set "OPENCV_ARCH=86")
if "%ARCH%" == "64" ( set "OPENCV_ARCH=64")

robocopy %LIBRARY_PREFIX%\x%OPENCV_ARCH%\vc%VS_MAJOR%\ %LIBRARY_PREFIX%\ *.* /E
if %ERRORLEVEL% GEQ 8 exit 1

rem Remove files installed in the wrong locations
rd /S /Q "%LIBRARY_BIN%\Release"
rd /S /Q "%LIBRARY_PREFIX%\x%OPENCV_ARCH%"
rem RD is a bit horrible and doesn't return an errorcode properly, so
rem the errorcode from robocopy is propagated (which is non-zero), so we
rem forcibly exit 0 here
exit 0
