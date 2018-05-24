#!/bin/bash

./docker_reset_containers.sh
./docker_start_mssql_test_database.sh

echo Pause 30 seconds to allow SQL Server to start up
sleep 30

echo Install tSQLt
mkdir -p test_results
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -Q "ALTER DATABASE master SET TRUSTWORTHY ON;"
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -i "tSQLt/tSQLt.class.sql" -o "test_results/Sales_Database_tSQLt_Install.txt"

echo Create database
liquibase --changeLogFile=src/test/db/changelog-with-unit-tests.xml update

echo Run the tSQLt unit tests
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -Q "sp_configure @configname=clr_enabled, @configvalue=1"
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -Q "RECONFIGURE"
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -Q "EXEC tSQLt.RunAll"

echo Make sure that the unit tests ran
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -Q "EXEC tSQLt.RunAll"

echo Make sure that the unit tests ran