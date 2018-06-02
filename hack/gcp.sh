#!/bin/bash

function setup_gcloud_noomi_vnext_dev {
    gcloud config configurations create noomi-vnext-dev
    gcloud config configurations activate noomi-vnext-dev
    gcloud auth activate-service-account \
    --key-file=/serviceaccounts/noomi-vnext-dev.json
    gcloud config set project noomi-vnext-dev-202112
    gcloud config set container/cluster be-dev
}

function setup_gcloud_noomi_vnext_ci {
    gcloud config configurations create noomi-vnext-ci
    gcloud config configurations activate noomi-vnext-ci
    gcloud auth activate-service-account \
    --key-file=/serviceaccounts/noomi-vnext-ci.json
    gcloud config set project noomi-vnext-ci
    gcloud config set compute/region europe-west1
    gcloud config set container/cluster ci
}

function main {
    local cmd=${1:-}
    case $cmd in
        setup-ci)
            setup_gcloud_noomi_vnext_ci
            ;;
        setup-dev)
            setup_gcloud_noomi_vnext_dev
            ;;
        use-ci)
            gcloud config configurations activate noomi-vnext-ci
            ;;
        use-dev)
            gcloud config configurations activate noomi-vnext-dev
            export GOOGLE_APPLICATION_CREDENTIALS=/serviceaccounts/noomi-vnext-dev.json
            ;;
        *)
            echo $"Usage: $0 {setup-ci|setup-dev|use-ci|use-dev}"
            exit 1
    esac
}

main $@
exit $?
