#!/bin/sh

APR_VER=1.5.2
APU_VER=1.5.4
API_VER=1.2.1

# These three are built together because the builds depend on one another.

MIRROR=http://www-us.apache.org/dist/

curl $MIRROR/apr/apr-${APR_VER}.tar.bz2 -o apr.tar.bz2
curl $MIRROR/apr/apr-util-${APU_VER}.tar.bz2 -o apr-util.tar.bz2
curl $MIRROR/apr/apr-iconv-${API_VER}.tar.bz2 -o apr-iconv.tar.bz2

tar -jxf apr.tar.bz2
tar -jxf apr-util.tar.bz2
tar -jxf apr-iconv.tar.bz2

mv apr-${APR_VER} apr
mv apr-util-${APU_VER} apr-util
mv apr-iconv-${API_VER} apr-iconv

cd apr
./configure --prefix=${PREFIX}
make
make install

cd ../apr-util
./configure --prefix=${PREFIX} --with-apr=${PREFIX}
make
make install

cd ../apr-iconv
./configure --prefix=${PREFIX} --with-apr=${PREFIX}
make
make install
