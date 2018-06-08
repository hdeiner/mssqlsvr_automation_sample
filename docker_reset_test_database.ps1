Write-host "Stop sqlsvrtest running in Docker container"
docker stop sqlsvrtest

Write-host "Remove sqlsvrtest from Docker container"
docker rm sqlsvrtest