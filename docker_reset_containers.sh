#!/bin/bash

echo Stop all Docker containers
sudo -S <<< "password" docker stop $(sudo -S <<< "password" docker ps -aq)

echo Remove exited Docker containers
sudo docker ps --filter status=dead --filter status=exited -aq | xargs -r sudo docker rm -v

echo Remove unused Docker images
sudo -S <<< "password" docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r sudo docker rmi