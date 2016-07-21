import sys
if 1:#tuple.__itemsize__ == 8 and sys.platform == 'win32':
    sys.exit(0)

# https://publicwiki.deltares.nl/display/OET/Reading+data+from+OpenDAP+using+python

if 0:
    # Read data from an opendap server
    import netCDF4
    # specify an url, the JARKUS dataset in this case
    url = 'http://dtvirt5.deltares.nl:8080/thredds/dodsC/opendap/rijkswaterstaat/jarkus/profiles/transect.nc'
    dataset = netCDF4.Dataset(url)
    # lookup a variable
    variable = dataset.variables['id']
    # print the first 10 values
    print(variable[0:10])
    assert variable[0] == 2000100

# run som eof the tests (which come with the source, but are copied here)
import sys
from subprocess import check_call

if sys.platform != 'win32':
    check_call([sys.executable, 'tst_compression.py'])

print("netcdf4 test OK")
