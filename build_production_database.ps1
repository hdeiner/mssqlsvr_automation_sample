Write-host Kill the current Docker sqlsvrprod container
.\docker_reset_production_database.ps1
Write-host Crete a fresh Docker sqlsvrprod container
.\docker_start_production_database.ps1

Write-host "Pause 60 seconds to allow SQL Server to start up"
Start-Sleep -s 60

Write-host Create database
liquibase --changeLogFile=src/main/db/changelog-legacy-schema.xml update