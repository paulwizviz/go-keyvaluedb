#!/bin/bash

export INFLUX_CMD_IMAGE=go-db/influxcmd:current
export INFLUX_CMD_CONTAINER=influxmiddleware
export NETWORK=go-db_influx-network

COMMAND="$1"

case $COMMAND in
    "build")
        docker-compose -f ./build/influxdb/docker-compose.yml build
        ;;
    "clean")
        docker rmi -f $INFLUX_CMD_IMAGE
        docker rmi -f $(docker images --filter "dangling=true" -q)
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