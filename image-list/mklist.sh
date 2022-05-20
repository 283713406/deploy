#!/bin/bash
declare -A allarch
allarch["x86_64"]="amd64"
allarch["aarch64"]="arm64"
RUNNERARCH=${allarch["$(uname -m)"]}

docker login registry.kylincloud.org -u wangqiwei -p Kylin123.

yq() {
  docker run --rm -i -v "${PWD}":/workdir registry.kylincloud.org/kcc/images/${RUNNERARCH}/yq:4 "$@"
}

function setNewline() {
    echo $line | grep harbor >/dev/null && {
        key=$(echo $line | awk '{print $1}')
	    value=$(echo $line | awk '{print $2}'| sed 's=\"==g' | sed 's=-'${arch}'==g' | awk -F'/' '{print "registry.kylincloud.org:4001/solution/"$2"/'${arch}'/"$NF}' | sed 's=solution-==g' | sed 's=-'${arch}'==g')
	    newline="$key \"$value\""
    } || newline=$(echo $line | sed 's=-'${arch}'==g')
}

for arch in arm64 amd64 ; do
    file_arch=${arch}
    echo "global:" > images-${file_arch}.yaml
    echo "  images:" >>  images-${file_arch}.yaml
    > ${file_arch}-images.list
    cat images_dev-${file_arch}.yaml | tail -n +3 | while read line; do 
        newline=""
        setNewline
        echo $newline | awk '{printf "    %-30s%s\n",$1,$2}' >> images-${file_arch}.yaml
        echo $line $newline | awk '{print $2","$4}' | sed 's="==g' >> ${file_arch}-images.list
    done
done

arch=arm64
file_arch=icbc
echo "global:" > images-${file_arch}.yaml
echo "  images:" >>  images-${file_arch}.yaml
> ${file_arch}-images.list
yq '. *= load("images_dev-'${file_arch}'.yaml")' images_dev-${arch}.yaml | tail -n +3 | while read line; do
    newline=""
    setNewline
    cat images_dev-${file_arch}.yaml | grep $(echo $line | awk -F'"' '{print $2}') >/dev/null && \
        echo $newline | awk '{printf "    %-30s%s\n",$1,$2}' >> images-${file_arch}.yaml
    echo $line $newline | awk '{print $2","$4}' | sed 's="==g' >> ${file_arch}-images.list
done
