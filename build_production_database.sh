#!/bin/bash

./docker_reset_containers.sh
./docker_start_test_database.sh

echo Pause 30 seconds to allow SQL Server to start up
sleep 30

echo Create database
liquibase --changeLogFile=src/main/db/changelog-legacy-schema.xml update