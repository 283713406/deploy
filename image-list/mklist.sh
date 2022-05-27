#!/bin/bash

offline=false
[ "$1" = "offline" ] && offline=true
projectarchfile=project.arch
# 无公司内网环境，无法制作项目定制镜像，需要传入offline参数
# 公司内网环境可以组装镜像列表，制作项目定制镜像
declare -A allarch
allarch["x86_64"]="amd64"
allarch["aarch64"]="arm64"
RUNNERARCH=${allarch["$(uname -m)"]}
$offline || docker login registry.kylincloud.org -u wangqiwei -p Kylin123.

yq() {
    docker run --rm -i -v "${PWD}":/workdir registry.kylincloud.org/kcc/images/${RUNNERARCH}/yq:4 "$@"
}

setNewLine() {
    echo $line | grep harbor >/dev/null && {
        key=$(echo $line | awk '{print $1}')
        value=$(echo $line | awk '{print $2}'| \
                sed 's=\"==g' | sed 's=-'${arch}'==g' | \
                awk -F'/' '{print "registry.kylincloud.org:4001/solution/"$2"/'${arch}'/"$NF}' | \
                sed 's=solution-==g' | sed 's=-'${arch}'==g')
        newline="$key \"$value\""
    } || newline=$(echo $line | sed 's=-'${arch}'==g')
}

archlist=$(ls images_dev-* | sed 's=.yaml==g' | awk -F'-' '{print $NF}')

for filearch in $archlist; do
    arch=$filearch
    case $filearch in
        arm64|amd64 ) arch=$filearch ;;
        * ) 
            cat $projectarchfile | grep $filearch >/dev/null || {
                echo "Project $filearch has no arch description in $projectarchfile"
                exit
            }
            arch=$(cat $projectarchfile | grep $filearch | awk '{print $2}') ;;
    esac
    echo "global:" > images-${filearch}.yaml
    echo "  images:" >>  images-${filearch}.yaml
    yamlvalue=$(cat images_dev-${filearch}.yaml)
    echo "$yamlvalue" | tail -n +3 | while read line; do
        newline=""
        setNewLine
        echo $newline | awk '{printf "    %-30s%s\n",$1,$2}' >> images-${filearch}.yaml
    done
    $offline && continue
    yamlvalue=$(yq '. *= load("images_dev-'${filearch}'.yaml")' images_dev-${arch}.yaml)
    > ${filearch}-images.list
    echo "$yamlvalue" | tail -n +3 | while read line; do
        newline=""
        setNewLine
        echo $line $newline | awk '{print $2","$4}' | sed 's="==g' >> ${filearch}-images.list
    done
done
