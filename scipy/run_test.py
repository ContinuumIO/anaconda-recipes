import scipy.integrate._test_multivariate
import scipy.optimize._zeros
import scipy.interpolate._interpolate
import scipy.special._comb
import scipy.optimize.minpack2
import scipy.optimize._nnls
import scipy.linalg._calc_lwork
import scipy.stats.statlib
import scipy.signal.spline
import scipy.io.matlab.mio_utils
import scipy.optimize.moduleTNC
import scipy.linalg._flinalg
import scipy.stats.mvn
import scipy.fftpack.convolve
import scipy.signal._spectral
import scipy.optimize._cobyla
import scipy.optimize._slsqp
import scipy.integrate._dop
import scipy.spatial._distance_wrap
import scipy.special._ellip_harm_2
import scipy.special._ufuncs_cxx
import scipy.optimize._minpack
import scipy.optimize._lbfgsb
import scipy.integrate._quadpack
import scipy.io.matlab.streams
import scipy.signal.sigtools
import scipy.integrate._odepack
import scipy.ndimage._nd_image
import scipy.integrate._test_odeint_banded
import scipy.integrate.lsoda
import scipy.cluster._vq
import scipy.integrate.vode
import scipy.sparse.csgraph._traversal
import scipy.interpolate._fitpack
import scipy.sparse.linalg.isolve._iterative
import scipy.optimize._lsq.givens_elimination
import scipy.sparse.csgraph._tools
import scipy.odr.__odrpack
import scipy.signal._max_len_seq_inner
import scipy.linalg._fblas
import scipy.optimize._group_columns
import scipy.fftpack._fftpack
import scipy.sparse.csgraph._min_spanning_tree
import scipy.io.matlab.mio5_utils
import scipy.signal._upfirdn_apply
import scipy.linalg._solve_toeplitz
import scipy.linalg.cython_blas
import scipy.sparse.csgraph._shortest_path
import scipy.interpolate.dfitpack
import scipy.stats._stats
import scipy.cluster._hierarchy
import scipy.ndimage._ni_label
import scipy.interpolate._ppoly
import scipy.linalg.cython_lapack
import scipy.sparse.linalg.eigen.arpack._arpack
import scipy.linalg._interpolative
import scipy.interpolate.interpnd
import scipy.sparse.csgraph._reordering
import scipy.sparse.linalg.dsolve._superlu
import scipy.special.specfun
import scipy.linalg._decomp_update
import scipy.linalg._flapack
import scipy.sparse._csparsetools
import scipy.spatial.qhull
import scipy.special._ufuncs
import scipy.spatial.ckdtree
import scipy.sparse._sparsetools

from cio_bt.mkl_link import test_modules
test_modules([
    scipy.integrate.vode,
    scipy.linalg._fblas,
    scipy.linalg._flapack,
    scipy.sparse.linalg.eigen.arpack._arpack,
    scipy.sparse.linalg.isolve._iterative,
])

import scipy.stats
import scipy.special

import sys
if sys.platform.startswith('linux'):
    scipy.test('full')
