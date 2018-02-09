#!/bin/bash

CONTAINERS=`docker ps --format "{{.Names}}"`

for CONTAINER in $CONTAINERS
do
    IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER`
    echo -e "$CONTAINER\t$IP"
done
