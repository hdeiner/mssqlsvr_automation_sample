Write-host Kill the current Docker sqlsvrtest container
.\docker_reset_test_database.ps1
Write-host Crete a fresh Docker sqlsvrtest container
.\docker_start_test_database.ps1

Write-host "Pause 60 seconds to allow SQL Server to start up"
Start-Sleep -s 60

Write-host Install tSQLt
new-item -name target/tSQLt -ItemType directory -Force
sqlcmd -S localhost,1433 -U sa -P 'Strong!Passw0rd' -Q "ALTER DATABASE master SET TRUSTWORTHY ON;"
sqlcmd -S localhost,1433 -U sa -P 'Strong!Passw0rd' -t 0 -i "tSQLt/tSQLt.class.sql" -o "target/tSQLt/Sales_Database_tSQLt_Install.txt"

Write-host Create database
liquibase --changeLogFile=src/test/db/changelog-with-unit-tests.xml update

Write-host Run the tSQLt unit tests
sqlcmd -S localhost,1433 -U sa -P 'Strong!Passw0rd' -Q "sp_configure @configname=clr_enabled, @configvalue=1"
sqlcmd -S localhost,1433 -U sa -P 'Strong!Passw0rd' -Q "RECONFIGURE"
sqlcmd -S localhost,1433 -U sa -P 'Strong!Passw0rd' -Q "EXEC tSQLt.RunAll"

Write-host Make sure that the unit tests ran
sqlcmd -S localhost,1433 -U sa -P 'Strong!Passw0rd' -Q "EXEC tSQLt.RunAll"