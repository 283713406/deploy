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

export node1Ip=$(get-nodeIp)



uninstall-all() {
   uninstall-apps
   echo "Wait 20s for clean......."
   sleep 20
   uninstall-all-pv-apps
   uninstall-has
   echo "Wait 10s for clean......."
   uninstall-all-pv-ha
   uninstall-pre
}
