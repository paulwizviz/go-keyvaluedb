#!/bin/bash

if [ "$(basename $(realpath .))" != "learn-keyvaluedb" ]; then
    echo "You are outside of the project"
    exit 0
else
    . ./scripts/images.sh
fi

COMMAND="$1"

function clean(){
    docker rmi -f ${LEVELDB_CMD_IMAGE}
    docker rmi -f $(docker images --filter "dangling=true" -q)
}

case $COMMAND in
    "build")
        build_leveldb
        ;;
    "shell")
        docker run --name testleveldb -it --rm ${LEVELDB_CMD_IMAGE} /bin/sh
        ;;
    "clean")
        clean_images
        ;;
    *)
        echo "$0 [ build | run | clean ]"
        ;;
esac