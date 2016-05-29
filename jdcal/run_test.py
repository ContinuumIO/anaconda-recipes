from jdcal import gcal2jd, jd2gcal

assert gcal2jd(2000,1, 1) == (2400000.5, 51544.0)
assert gcal2jd(2001,2,30) == (2400000.5, 51970.0)
assert jd2gcal(2400000.5, 51544.75) == (2000, 1, 1, 0.75)
