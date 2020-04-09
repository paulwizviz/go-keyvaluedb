#!/bin/bash

export LEVELDB_CMD_IMAGE=go-db/leveldb:current

COMMAND="$1"

function build(){
    docker-compose -f ./build/leveldb/docker-compose.yml build
}

function clean(){
    docker rmi -f ${LEVELDB_CMD_IMAGE}
    docker rmi -f $(docker images --filter "dangling=true" -q)
}

case $COMMAND in
    "build")
        build
        ;;
    "shell")
        docker run --name testleveldb -it --rm ${LEVELDB_CMD_IMAGE} /bin/sh
        ;;
    "clean")
        clean
        ;;
    *)
        echo "$0 [ build | run | clean ]"
        ;;
esac