#!/bin/bash

if [ "$(basename $(realpath .))" != "learn-keyvaluedb" ]; then
    echo "You are outside of the project"
    exit 0
else
    . ./scripts/images.sh
fi

export INFLUX_CMD_CONTAINER=influxmiddleware
export NETWORK=lean-keyvaluedb_influx-network

COMMAND="$1"

case $COMMAND in
    "build")
        build_influxdb
        ;;
    "clean")
        clean_images
        ;;
    "start")
        docker-compose -f ./deployment/influxdb/docker-compose.yml up
        ;;
    "stop")
        docker-compose -f ./deployment/influxdb/docker-compose.yml down
        ;;
    *)
        echo "$0 [ build | clean | start | stop ]"
        ;;
esac