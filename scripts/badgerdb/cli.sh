#!/bin/bash

export BADGERDB_CLI_IMAGE=go-db/badgercli:current
export BADGERDB_CLI_CONTAINER=badgerdbcli

COMMAND="$1"

function build(){
    docker-compose -f ./build/badgerdb/builder.yml build
}

function clean(){
    docker rmi -f ${BADGERDB_CLI_IMAGE}
    docker rmi -f $(docker images --filter "dangling=true" -q)
}

case $COMMAND in
    "build")
        build
        ;;
    "shell")
        docker run --name ${BADGERDB_CLI_CONTAINER} -w /opt -it --rm ${BADGERDB_CLI_IMAGE} /bin/bash
        ;;
    "clean")
        clean
        ;;
    *)
        echo "$0 [ build | run | clean ]"
        ;;
esac