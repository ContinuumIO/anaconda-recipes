import cvxopt.amd
import cvxopt.base
import cvxopt.blas
import cvxopt.cholmod
import cvxopt.lapack
import cvxopt.misc_solvers
import cvxopt.umfpack

from cio_bt.mkl_link import test_modules
test_modules([
    cvxopt.base,
    cvxopt.blas,
    cvxopt.cholmod,
    cvxopt.lapack,
    cvxopt.misc_solvers,
    cvxopt.umfpack,
])
