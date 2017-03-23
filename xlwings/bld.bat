del "xlwings\tests\~$test book.xlsx"
if errorlevel 1 exit 1

%PYTHON% setup.py install
if errorlevel 1 exit 1
