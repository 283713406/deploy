#!/usr/bin/env bash

source scripts/ha-common.sh
source scripts/app-common.sh

#IMAGELIST=image-list/images-arm64.yaml
#IMAGELIST=image-list/images-amd64.yaml
IMAGELIST=image-list/images_dev-arm64.yaml
#IMAGELIST=image-list/images_dev-amd64.yaml

ARCH=$(uname -m)

#ARGS='--debug'
ARGS=''

if [ $ARCH = "arm64" ]
then
   ARCH=arm64
elif [ $ARCH = "x86_64" ]
then
   ARCH=amd64
fi
