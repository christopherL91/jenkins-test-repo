#!/bin/bash

function main {
    echo "hello from setup_docker.sh"
    docker version
    docker ps
}

main $@
exit $?
