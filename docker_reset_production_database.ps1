Write-host "Stop sqlsvrprod running in Docker container"
docker stop sqlsvrprod

Write-host "Remove sqlsvrprod from Docker container"
docker rm sqlsvrprod