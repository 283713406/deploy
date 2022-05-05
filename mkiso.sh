#!/bin/bash
set -xe

# 环境变量
echo 【-】读取环境变量
######################
username=wangqiwei
password=Kylin123.
## 架构
declare -A allarch
allarch["x86_64"]="amd64"
allarch["aarch64"]="arm64"
arch=${allarch["$(uname -m)"]}
registry_path=$(pwd)/output/file
IMAGE=registry.kylincloud.org:4001/solution/deploy/${arch}/registry:latest

## 镜像拷贝工具，使用: $skopeo -v
skopeo="docker run --net host --rm --privileged registry.kylincloud.org/wangqiwei/mkiso/${arch}/skopeo:1.7.0"

# 初始化文件夹
echo 【-】初始化文件夹
######################
rm -rf container-solution output
mkdir -p container-solution
mkdir -p output/{file,iso}

# 搭建镜像仓库
echo 【-】搭建镜像仓库
######################
docker login -u  ci_wang  -p u1kblcakBlrHxAbxlbu0AFdca0xMvBlx harbor.kylincloud.org
docker login -u wangqiwei -p Kylin123. registry.kylincloud.org:4001
docker login -u wangqiwei -p Kylin123. registry.kylincloud.org

docker ps -a| grep container_solution >/dev/null && {
    docker stop container_solution && docker rm container_solution
} || true
docker run -d \
    -v ${registry_path}/container-solution:/var/lib/registry \
    -p 4001:5000 --restart=always \
    --name container_solution ${IMAGE}


# 修改harbor镜像tag为registry
echo 【-】组织镜像列表
######################
> ${arch}-gitlab
cat image-list/images_dev-${arch}.yaml | tail -n +3 | sed 's=\"==g'| awk '{print $2}' | while read line; do
    echo -e "${line},\c"
    newline=
    echo $line |grep harbor >/dev/null && {
        newline=$(echo $line | sed 's=-'${arch}'==g' | awk -F'/' '{print "registry.kylincloud.org:4001/solution/"$2"/'${arch}'/"$NF}' | sed 's=solution-==g')
        docker tag $line $newline
    } || newline=$line
    echo $newline | sed 's=registry.kylincloud.org=localhost=g'
done >> ${arch}-gitlab

# 拷贝镜像
echo 【-】拷贝镜像
######################
cat ${arch}-gitlab | while read line; do
    oldtag=$(echo $line |awk -F',' '{print $1}')
    newtag=$(echo $line |awk -F',' '{print $2}')
    $skopeo copy --dest-tls-verify=false --src-creds=${username}:${password} docker://${oldtag} docker://${newtag}
done

# 打包ISO
echo 【-】打包ISO
######################
cp image-list/images-${arch}.yaml   output/file/images.yaml
cp image-list/expand-mirror output/file/
cp image-list/README-iso.md     output/file/README.md
docker save -o output/file/kylin-container-registry-solution.tar ${IMAGE}
pushd output/file/ >/dev/null
gzexe expand-mirror
rm -rf expand-mirror~
popd >/dev/null


# 提交版本
echo 【-】提交版本
######################
version_date=$(date "+%y%m%d")
version=$(date "+%y%m%d-%H%M%S")
iso=container-solution-${arch}-${version}.iso
mkisofs -allow-limited-size -l -J -r -iso-level 3 -o output/iso/${iso} output/file/
md5_value=$(md5sum output/iso/${iso} | awk '{print $1}')
exit
user="root"
host="172.20.188.156"
gitcommit=$(git log | head -1 | awk '{print substr($2,0,10)}')
mkdir -p  ~/.ssh
cat .id_rsa | base64 -d > ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa
scp -o "StrictHostKeyChecking no" output/iso/${iso} ${user}@${host}:/ahanwhite/container/iso/solution/${arch}/
ssh -o "StrictHostKeyChecking no" ${user}@${host} "echo \"|v${version_date}|${arch}|[${iso}](./${arch}/${iso})|${md5_value}|${gitcommit}||\" >> /ahanwhite/container/iso/solution/.readme-notice"

