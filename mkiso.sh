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

# 初始化文件夹
#rm -rf /docker/registry/container-solution output
mkdir -p /docker/registry/container-solution
mkdir -p output/{file,iso}

# 初始化镜像
#IMAGE=registry.kylincloud.org:4001/solution/deploy/${ARCH}/registry:latest
#docker ps -a| grep container_solution >/dev/null && {
#    docker stop container_solution && docker rm container_solution
#} || true
#
#docker run -d \
#    -v /docker/registry/container-solution:/var/lib/registry \
#    -p 4001:5000 --restart=always \
#    --name container_solution ${IMAGE}


docker login -u  ci_wang  -p u1kblcakBlrHxAbxlbu0AFdca0xMvBlx harbor.kylincloud.org
docker login -u wangqiwei -p Kylin123. registry.kylincloud.org:4001
[ $CI ] && {
  docker login -u  push  -p kylincloud@123.  $CI_REGISTRY
}

# 拉取镜像
cat image-list/${ARCH} | while read line; do
	docker pull $line;
done

# 修改harbor镜像tag为registry
> ${ARCH}-gitlab
cat image-list/${ARCH} | while read line; do
    echo $line |grep harbor >/dev/null && {
        newline=$(echo $line | sed 's=-'${ARCH}'==g' | awk -F'/' '{print "registry.kylincloud.org:4001/solution/"$2"/arm64/"$NF}' | sed 's=solution-==g')
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
pushd /docker/registry/ >/dev/null
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

version=$(date "+%y%m%d-%H%M%S")
iso=container-solution-${ARCH}-${version}.iso
mkisofs -allow-limited-size -l -J -r -iso-level 3 -o output/iso/${iso} output/file/
md5_value=$(md5sum output/iso/${iso} | awk '{print $1}')

