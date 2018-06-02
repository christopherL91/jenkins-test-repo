#!/bin/bash

function main {
    local cmd=${1:-}
    case $cmd in
        configure-docker-helper)
            gcloud auth configure-docker --quiet
            ;;
        *)
            echo $"Usage: $0 {configure-docker-helper}"
            exit 1
    esac
}

main $@
exit $?
