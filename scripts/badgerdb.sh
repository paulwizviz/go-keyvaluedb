#!/bin/bash

if [ "$(basename $(realpath .))" != "learn-keyvaluedb" ]; then
    echo "You are outside of the project"
    exit 0
else
    . ./scripts/images.sh
fi


export BADGERDB_CLI_CONTAINER=badgerdbcli

COMMAND="$1"

function clean(){
    docker rmi -f ${BADGERDB_CLI_IMAGE}
    docker rmi -f $(docker images --filter "dangling=true" -q)
}

case $COMMAND in
    "build")
        build_badgerdb
        ;;
    "clean")
        clean_images
        ;;
    "shell")
        docker run --name ${BADGERDB_CLI_CONTAINER} -w /opt -it --rm ${BADGERDB_CLI_IMAGE} /bin/bash
        ;;
    *)
        echo "$0 [ build | run | clean ]"
        ;;
esac