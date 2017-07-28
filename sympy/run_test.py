import sympy
from sympy import Rational


a = Rational(14, 4)
assert str(a) == '7/2'

assert sympy.__version__ == '1.1.1'
