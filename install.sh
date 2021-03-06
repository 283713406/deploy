#!/usr/bin/env bash

if [ "$DEVMODE" = true ]
then
   export IMAGEPATH='image-list/images_dev'
   echo '采用开发者部署模式:
请确认内部开发者源地址可以访问
harbor.kylincloud.org   registry.kylincloud.org.'
else
   export IMAGEPATH='image-list/images'
   echo '采用生产环境部署模式:
请确认生产镜像已展开,registry服务已就绪
,且各个服务端的对应registry.kylincloud.org域名的hosts映射已配置.'
fi

ARGS=''

ARCH=$(uname -m)

if [ $ARCH = "aarch64" ]
then
   export ARCH=arm64
elif [ $ARCH = "x86_64" ]
then
   export ARCH=amd64
fi

FILEARCH=$ARCH
[ $# -gt 0 ] && {
    [ -f ${IMAGEPATH}-$1.yaml ] || {
        echo -e "\033[31m\nERROR: 参数错误：$1，\c"
        echo -e "只支持$(ls image-list/images-*| sed 's=.yaml==g' | awk -F '-' '{printf " "$3}')\033[0m"
        return
    }
    FILEARCH=$1
}

export PROJECTIMAGELIST=${IMAGEPATH}-${FILEARCH}.yaml

export IMAGELIST=" ${IMAGEPATH}-${ARCH}.yaml -f ${PROJECTIMAGELIST}"

export GVALUE="-f ${IMAGELIST}  -f values/global-values.yaml"

source scripts/ha-common.sh
source scripts/app-common.sh
source scripts/pre-common.sh
source scripts/module-common.sh
source scripts/debug.sh

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
