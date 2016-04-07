import teradata

udaExec = teradata.UdaExec(appName="HelloWorld", version="1.0",
                           logConsole=False)

#session = udaExec.connect(method="odbc", system="tdprod",
#        username="xxx", password="xxx");

#for row in session.execute("SELECT GetQueryBand()"):
#    print(row)
