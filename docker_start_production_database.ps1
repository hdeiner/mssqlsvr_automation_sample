Write-host "Starting microsoft/mssql-server-windows-developer:latest in Docker container"
docker run `
   -e ACCEPT_EULA=Y `
   -e sa_password=Strong!Passw0rd `
   -p 1433:1433 --name sqlsvrprod `
   -d microsoft/mssql-server-windows-developer:latest