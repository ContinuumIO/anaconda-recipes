if [ $ARCH == 32 ]; then
    export "CFLAGS=$CFLAGS -march=i486"
    export "CXXFLAGS=$CXXFLAGS -march=i486"
fi

./configure --prefix=$PREFIX
make
make install


rm $PREFIX/share/glib-2.0/codegen/*.pyc
