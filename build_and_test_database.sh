#!/bin/bash

./docker_reset_containers.sh
./docker_start_mssql_test_database.sh

echo Pause a quarter of a minute to allow SQL Server to start up
sleep 15

echo Install tSQLt
mkdir -p test_results
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -Q "ALTER DATABASE master SET TRUSTWORTHY ON;"
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -i "tSQLt/tSQLt.class.sql" -o "test_results/Sales_Database_tSQLt_Install.txt"

echo Create database
liquibase --changeLogFile=src/main/db/changelog-legacy-schema.xml update

echo Run the tSQLt unit tests
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -Q "sp_configure @configname=clr_enabled, @configvalue=1"
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -Q "RECONFIGURE"
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -i test_tsqlt_01_create_test.txt
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -i test_tsqlt_02_create_code_to_test.txt
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -i test_tsqlt_03_run_test.txt -o "test_results/Sales_Database_tSQLt_Report.txt"

echo Make sure that the unit tests ran
sqlcmd -S localhost -U SA -P 'Strong!Passw0rd' -i test_tsqlt_03_run_test.txt -o "test_results/Sales_Database_tSQLt_Report.txt"
cat test_results/Sales_Database_tSQLt_Report.txt