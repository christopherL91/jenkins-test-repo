#!/bin/bash

function main {
    echo "hello from setup_docker.sh"
    sudo docker version
    sudo docker ps
}

main $@
exit $?
