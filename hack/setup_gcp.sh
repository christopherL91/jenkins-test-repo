#!/bin/bash

function main {
    echo "Listing accounts"
    gcloud auth list
    echo "Activating new service account"
    gcloud auth activate-service-account --key-file=${GCSKEY}
}

main $@
exit $?
