import sys

import osgeo._gdal
import osgeo._gdal_array
import osgeo._gdalconst
import osgeo._ogr
import osgeo._osr
import osgeo
import gdal
import gdalconst
import ogr
import osr

# Set GDAL_DATA. This is done normally done by the activate script,
# but this doesn't happen in the testing environment
import os
if 'LIBRARY_PREFIX' in os.environ:
    # Windows
    gdalData = os.path.join(os.environ['LIBRARY_PREFIX'], 'share', 'gdal')
else:
    # Linux/OSX
    gdalData = os.path.join(os.environ['PREFIX'], 'share', 'gdal')

os.environ['GDAL_DATA'] = gdalData

driver = gdal.GetDriverByName("netCDF")
assert driver is not None

driver = gdal.GetDriverByName("HDF4")
assert driver is not None

driver = gdal.GetDriverByName("HDF5")
assert driver is not None

# only available when libkea successfully linked in
driver = gdal.GetDriverByName("KEA")
assert driver is not None

# only available when xerces-c++ successfully linked in
driver = ogr.GetDriverByName("GML")
assert driver is not None

# now test for GEOS support
ogr.UseExceptions()
g1 = ogr.Geometry(wkt='POLYGON((0 0, 10 10, 10 0, 0 0))')
g2 = ogr.Geometry(wkt='POLYGON((-90 -90, -90 90, 190 -90, -90 -90))')
# following line raises exception if no GEOS
g1.Contains(g1)

# test for proj.4 support
osr.UseExceptions()
sr1 = osr.SpatialReference()
sr1.ImportFromEPSG(4326) # lat long
sr2 = osr.SpatialReference()
sr2.ImportFromEPSG(28355) # GDA94 / MGA zone 55
# following line raises exception if no proj.4
trans = osr.CoordinateTransformation(sr1, sr2)

