#!/usr/bin/env bash

source scripts/ha-common.sh
source scripts/app-common.sh
source scripts/pre-common.sh

#IMAGELIST=image-list/images-arm64.yaml
#IMAGELIST=image-list/images-amd64.yaml
export IMAGELIST=image-list/images_dev-arm64.yaml
#IMAGELIST=image-list/images_dev-amd64.yaml


ARGS=''

ARCH=$(uname -m)

if [ $ARCH = "arm64" ]
then
   export ARCH=arm64
elif [ $ARCH = "x86_64" ]
then
   export ARCH=amd64
fi

export nodeIp="172.20.192.126"
# $(kubectl get nodes --selector=kubernetes.io/role!=master -o jsonpath={.items[*].status.addresses[?\(@.type==\"ExternalIP\"\)].address})
