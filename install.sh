#!/bin/bash
set -x

current_path=$(cd $(dirname $0); pwd)

amd64_image='registry.kylincloud.org:4001/solution/tianyu/amd64/nfs-client-provisioner:20220217'
arm64_image='registry.kylincloud.org:4001/solution/tianyu/arm64/nfs-client-provisioner-arm64:20220217'

function usage() {
  echo "This script install nfs storageClass."
  echo "Usage: install.sh <NFS_SERVER> <NFS_PATH> "
  echo "Example: bash install.sh 172.20.1.1 /opt/nfs"
}

if [[ $# -lt 2 ]]; then
  usage
  exit 1
fi

NFS_SERVER=$1
if [[ -z "${NFS_SERVER}" ]]; then
  usage
  exit 1
fi

NFS_PATH=$2
if [[ -z "${NFS_PATH}" ]]; then
  usage
  exit 1
fi

echo "[INFO] 开始安装nfs storageClass..."

cp ${current_path}/nfs.yaml ${current_path}/nfs.yaml.bak
sed -i "s#NFS_SERVER_VALUE#${NFS_SERVER}#g" ${current_path}/nfs.yaml
sed -i "s#NFS_PATH_VALUE#${NFS_PATH}#g" ${current_path}/nfs.yaml

architecture=$(uname -m)
case $architecture in
    amd64|x86_64)
      sed -i "s#${arm64_image}#${amd64_image}#g" ${current_path}/nfs.yaml
        ;;
    aarch64|arm64)
      continue
        ;;
    # not supported
    *)
      echo "[ERROR] this arch not supported"
      exit 1
        ;;
esac

kubectl apply -f ${current_path}/nfs.yaml

mv ${current_path}/nfs.yaml.bak ${current_path}/nfs.yaml
