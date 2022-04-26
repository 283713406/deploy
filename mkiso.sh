#!/bin/bash
set -xe

# 获取架构
if [ ! ${ARCH} ]; then
  MACHINE=`uname -m`
  if [ "${MACHINE}" == "x86_64" ]; then
    ARCH=amd64
  elif [ "${MACHINE}" == "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown machine" && exit 1
  fi
fi

registry_path=$(pwd)

# 初始化文件夹
rm -rf container-solution output
mkdir -p container-solution
mkdir -p output/{file,iso}

# 登录仓库
docker login -u  ci_wang  -p u1kblcakBlrHxAbxlbu0AFdca0xMvBlx harbor.kylincloud.org
docker login -u wangqiwei -p Kylin123. registry.kylincloud.org:4001
docker login -u wangqiwei -p Kylin123. registry.kylincloud.org

# 初始化镜像
IMAGE=registry.kylincloud.org:4001/solution/deploy/${ARCH}/registry:latest
docker ps -a| grep container_solution >/dev/null && {
    docker stop container_solution && docker rm container_solution
} || true

docker run -d \
    -v ${registry_path}/container-solution:/var/lib/registry \
    -p 4001:5000 --restart=always \
    --name container_solution ${IMAGE}

# 拉取镜像
cat image-list/images_dev-${ARCH}.yaml | tail -n +3 | sed 's=\"==g'| awk '{print $2}' | while read line; do
	docker pull $line;
done

# 修改harbor镜像tag为registry
> ${ARCH}-gitlab
cat image-list/images_dev-${ARCH}.yaml | tail -n +3 | sed 's=\"==g'| awk '{print $2}' | while read line; do
    echo $line |grep harbor >/dev/null && {
        newline=$(echo $line | sed 's=-'${ARCH}'==g' | awk -F'/' '{print "registry.kylincloud.org:4001/solution/"$2"/'${ARCH}'/"$NF}' | sed 's=solution-==g')
        docker tag $line $newline
        echo $newline
    } || echo $line
done >> ${ARCH}-gitlab


cat ${ARCH}-gitlab | while read line; do
    newline=$(echo $line| sed 's=-'${ARCH}'==g' | sed 's=registry.kylincloud.org=localhost=g')
    docker tag $line $newline
    docker push $newline
done

# 打包镜像文件
pushd ${registry_path} >/dev/null
tar czf $(dirs -l| awk '{printf $NF}')/output/file/container-solution.tar.gz container-solution
popd >/dev/null

# 拷贝相关文件
cp image-list/images-${ARCH}.yaml   output/file/images.yaml
cp image-list/expand-mirror output/file/
cp image-list/README-iso.md     output/file/README.md
docker save -o output/file/kylin-container-registry-solution.tar ${IMAGE}
pushd output/file/ >/dev/null
gzexe expand-mirror
rm -rf expand-mirror~
popd >/dev/null

version_date=$(date "+%y%m%d")
version=$(date "+%y%m%d-%H%M%S")
iso=container-solution-${ARCH}-${version}.iso
mkisofs -allow-limited-size -l -J -r -iso-level 3 -o output/iso/${iso} output/file/
md5_value=$(md5sum output/iso/${iso} | awk '{print $1}')

user="root"
host="172.20.188.156"
gitcommit=$(git log | head -1 | awk '{print substr($2,0,10)}')
mkdir -p  ~/.ssh
cat .id_rsa | base64 -d > ~/.ssh/id_rsa
scp -o "StrictHostKeyChecking no" output/iso/${iso} ${user}@${host}:/ahanwhite/container/iso/solution/${ARCH}/
ssh -o "StrictHostKeyChecking no" ${user}@${host} "echo \"|v${version_date}|${ARCH}|[${iso}](./${ARCH}/${iso})|${md5_value}|${gitcommit}||\" >> /ahanwhite/container/iso/solution/.readme-notice"

