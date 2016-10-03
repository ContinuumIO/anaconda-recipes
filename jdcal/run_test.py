import jdcal

assert jdcal.gcal2jd(2000,1, 1) == (2400000.5, 51544.0)
assert jdcal.gcal2jd(2001,2,30) == (2400000.5, 51970.0)
assert jdcal.jd2gcal(2400000.5, 51544.75) == (2000, 1, 1, 0.75)
assert jdcal.__version__ == '1.3'
