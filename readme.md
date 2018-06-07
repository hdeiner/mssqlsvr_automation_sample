This project demonstrates the automated creation and testing of MS SQLSVR Databases.

We use Docker containers to house the databases, to allow us test isolation in each environment where the testing is done.

"docker_reset_containers.sh" is a brute force container manager that cleans up everything (perhaps too much) from the local enviroment.

See https://hub.docker.com/r/microsoft/mssql-server-linux/ for a list of Microsoft supported Docker images ready to be pulled!

See https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-2017 for instructions on installation of MS SQLSVR ODBC drivers for various platforms.  At the time this README is written, the Ubuntu 18.04 drivers are not yet released, but the 17.10 drivers seem to work OK.

Actually, forget that last tidbit.  Liquibase must use JDBC drivers because it calls from a Java environment.  Therefore, look to https://docs.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server?view=sql-server-2017 for guidance.

sqlcmd -S localhost -U SA -P 'Strong!Passw0rd'

For this project, the schema was "borrowed" from https://msdn.microsoft.com/en-us/library/jj851212(v=vs.103).aspx.  I have minimally massaged the database creation commands into src/main/db/changelog-legacy-schema.xml, which in turn pulls in files for legacy-schema.sql, legacy-schema-static-data.sql and five storedProcedures for cancelOrder.sql, fillOrder.sql, testNewCustomer.sql, testPlaceNewOrder.sql, and showOrderDetails.sql.

At this point, one can run the following to create the MSSQL Database:
```bash
./docker_reset_containers.sh 
./docker_start_mssql_test_database.sh
liquibase --changeLogFile=src/main/db/changelog-legacy-schema.xml update
```
While Microsoft SQL Server has come a long way, unit tests for stored procedures are still something that isn't fully supported outside of the GUI for "SQL Server Unit Test Designer".  Hence, we have to turn to tSQLt, the open source database unit testing framework for SQL Server.  https://tsqlt.org/  I am using tSQLt_V1.0.5873.27393 for this project.

Still in trouble:
1) Liquibase handling of stored procedures
2) Having to run the tSQLt test runner twice to see the results

* Need SQL Server command-line tools on Linux: 
  * https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-linux-2017
* Using sqlops: Microsoft SQL Operations Studio on Linux to look at and demo database created.  
  * https://docs.microsoft.com/en-gb/sql/sql-operations-studio/what-is?view=sql-server-linux-2017  
  * https://docs.microsoft.com/en-gb/sql/sql-operations-studio/download?view=sql-server-linux-2017
