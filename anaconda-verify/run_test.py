from anaconda_verify import __version__
from anaconda_verify.package import CondaPackageCheck

assert CondaPackageCheck.no_easy_install_script
assert __version__ == '1.3.8', __version__
