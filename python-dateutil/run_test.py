from dateutil.relativedelta import relativedelta
from dateutil.easter import easter
from dateutil.rrule import rrule, YEARLY, FR
from dateutil.parser import parse
from dateutil.tz import tzlocal


then = parse("Sat Oct 11 17:13:46 UTC 2003")
today = then.date()
print("Then was: %s" % today)
assert str(today) == '2003-10-11'

year = rrule(YEARLY, dtstart=then, bymonth=8,
             bymonthday=13, byweekday=FR)[0].year
rdelta = relativedelta(easter(year), today)

print("Year with next Aug 13th on a Friday is: %s" % year)
assert str(year) == '2004'
print("How far is the Easter of that year: %s" % rdelta)
assert str(rdelta) == 'relativedelta(months=+6)'
print("And the Easter of that year is: %s" % (today + rdelta))
assert str(today + rdelta) == '2004-04-11'

# test with standard library
import time
import datetime
now = datetime.datetime.now(tzlocal())
rfc822 = "%a, %d %b %Y %H:%M:%S %z"
print("Now in RFC822: %s" % now.strftime(rfc822))
iso8601 = "%Y-%m-%dT%H:%M:%S%z"
print("Now in ISO8601: %s" % now.strftime(iso8601))

ns = time.strftime("%Y-%m-%d %H:%M:%S")
print("A: '%s'" % ns)
now = parse(ns)
print("B: '%s'" % now)
assert str(now) == ns
