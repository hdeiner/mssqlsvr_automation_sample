#!/bin/bash

echo Run the Docker image for Microsoft SQL Server test database
sudo -S <<< "password" sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Strong!Passw0rd' \
   -p 1433:1433 --name sqlsvr \
   -d microsoft/mssql-server-linux:latest