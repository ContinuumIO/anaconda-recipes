bash configure CC=msvcc.sh CXX=msvcc.sh LD=link CPP="cl -nologo -EP" --prefix=%LIBRARY_PREFIX%
jom install
