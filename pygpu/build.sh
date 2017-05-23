#!/bin/bash

export CFLAGS=${CFLAGS}" -I${PREFIX}/include -L${PREFIX}/lib"
$PYTHON setup.py install --single-version-externally-managed --record=record.txt

if [ `uname` == Linux ]
then
    mkdir -p $PREFIX/etc/conda/activate.d
    mkdir -p $PREFIX/etc/conda/deactivate.d

    cat <<EOF > $PREFIX/etc/conda/activate.d/pygpu_vars.sh
export CPATH_PYGPU_BACKUP="\$CPATH"
export CPATH=$PREFIX/include:"\$CPATH"
export LIBRARY_PATH_PYGPU_BACKUP="\$LIBRARY_PATH"
export LIBRARY_PATH=$PREFIX/lib:"\$LIBRARY_PATH"
export LD_LIBRARY_PATH_PYGPU_BACKUP="\$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=$PREFIX/lib:"\$LD_LIBRARY_PATH"
EOF

    cat <<EOF > $PREFIX/etc/conda/deactivate.d/pygpu_vars.sh
export CPATH="\$CPATH_PYGPU_BACKUP"
unset CPATH_PYGPU_BACKUP
export LIBRARY_PATH="\$LIBRARY_PATH_PYGPU_BACKUP"
unset LIBRARY_PATH_PYGPU_BACKUP
export LD_LIBRARY_PATH="\$LD_LIBRARY_PATH_PYGPU_BACKUP"
unset LD_LIBRARY_PATH_PYGPU_BACKUP
EOF
fi
