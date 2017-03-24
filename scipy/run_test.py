import scipy._lib._ccallback_c
import scipy._lib._test_ccallback
import scipy.cluster._hierarchy
import scipy.cluster._vq
import scipy.fftpack._fftpack
import scipy.fftpack.convolve
import scipy.integrate._dop
import scipy.integrate._odepack
import scipy.integrate._quadpack
import scipy.integrate._test_multivariate
import scipy.integrate._test_odeint_banded
import scipy.integrate.lsoda
import scipy.integrate.vode
import scipy.interpolate._bspl
import scipy.interpolate._fitpack
import scipy.interpolate._interpolate
import scipy.interpolate._ppoly
import scipy.interpolate.dfitpack
import scipy.interpolate.interpnd
import scipy.io.matlab.mio5_utils
import scipy.io.matlab.mio_utils
import scipy.io.matlab.streams
import scipy.linalg._calc_lwork
import scipy.linalg._decomp_update
import scipy.linalg._fblas
import scipy.linalg._flapack
import scipy.linalg._flinalg
import scipy.linalg._interpolative
import scipy.linalg._solve_toeplitz
import scipy.linalg.cython_blas
import scipy.linalg.cython_lapack
import scipy.ndimage._ctest
import scipy.ndimage._ctest_oldapi
import scipy.ndimage._cytest
import scipy.ndimage._nd_image
import scipy.ndimage._ni_label
import scipy.odr.__odrpack
import scipy.optimize._cobyla
import scipy.optimize._group_columns
import scipy.optimize._lbfgsb
import scipy.optimize._lsq.givens_elimination
import scipy.optimize._minpack
import scipy.optimize._nnls
import scipy.optimize._slsqp
import scipy.optimize._zeros
import scipy.optimize.minpack2
import scipy.optimize.moduleTNC
import scipy.signal._max_len_seq_inner
import scipy.signal._spectral
import scipy.signal._upfirdn_apply
import scipy.signal.sigtools
import scipy.signal.spline
import scipy.sparse._csparsetools
import scipy.sparse._sparsetools
import scipy.sparse.csgraph._min_spanning_tree
import scipy.sparse.csgraph._reordering
import scipy.sparse.csgraph._shortest_path
import scipy.sparse.csgraph._tools
import scipy.sparse.csgraph._traversal
import scipy.sparse.linalg.dsolve._superlu
import scipy.sparse.linalg.eigen.arpack._arpack
import scipy.sparse.linalg.isolve._iterative
import scipy.spatial._distance_wrap
import scipy.spatial._hausdorff
import scipy.spatial._voronoi
import scipy.spatial.ckdtree
import scipy.spatial.qhull
import scipy.special._comb
import scipy.special._ellip_harm_2
import scipy.special._test_round
import scipy.special._ufuncs
import scipy.special._ufuncs_cxx
import scipy.special.cython_special
import scipy.special.specfun
import scipy.stats._stats
import scipy.stats.mvn
import scipy.stats.statlib


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
import platform

if sys.platform.startswith('linux') and platform.machine() != 'ppc64le':
    scipy.test('full')
