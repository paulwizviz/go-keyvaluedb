#!/bin/bash

export LEVELDB_CMD_IMAGE=learn-keyvaluedb/leveldb:current
export BADGERDB_CLI_IMAGE=lean-keyvaluedb/badgercli:current
export INFLUX_CMD_IMAGE=lean-keyvaluedb/influxcmd:current

function build_badgerdb(){
    docker-compose -f ./build/builder.yml build badgerdb
}

function build_leveldb(){
    docker-compose -f ./build/builder.yml build leveldb
}

function build_influxdb(){
    docker-compose -f ./build/builder.yml build influxdb
}

function clean_images(){
    docker rmi -f ${INFLUX_CMD_IMAGE}
    docker rmi -f ${BADGERDB_CLI_IMAGE}
    docker rmi -f ${LEVELDB_CMD_IMAGE}
    docker rmi -f $(docker images --filter "dangling=true" -q)
}