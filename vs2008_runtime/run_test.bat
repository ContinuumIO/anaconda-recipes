:: check that the FMOD patch (additional to SP1) is applied:
curl -LO https://download.sysinternals.com/files/Sigcheck.zip
7za x Sigcheck.zip
FOR /F "tokens=* delims=" %%A in ('sigcheck.exe -q -n -vt -nobanner "%PREFIX%\msvcr90.dll"') do (
    if not "%%A" == "%PKG_VERSION%" exit 1
)