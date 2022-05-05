#!/bin/bash

for arch in arm64 amd64; do
echo "global:" > images-${arch}.yaml
echo "  images:" >>  images-${arch}.yaml
> ${arch}-images.list
cat images_dev-${arch}.yaml | tail -n +3 | while read line; do 
    newline=""
    echo $line | grep harbor >/dev/null && {
        key=$(echo $line | awk '{print $1}')
	    value=$(echo $line | awk '{print $2}'| sed 's=\"==g' | sed 's=-'${arch}'==g' | awk -F'/' '{print "registry.kylincloud.org:4001/solution/"$2"/'${arch}'/"$NF}' | sed 's=solution-==g' | sed 's=-'${arch}'==g')
	newline="$key \"$value\""
} || newline=$(echo $line | sed 's=-'${arch}'==g')
    echo $newline | awk '{printf "    %-30s%s\n",$1,$2}' >> images-${arch}.yaml
    echo $line $newline | awk '{print $2","$4}' | sed 's="==g' >> ${arch}-images.list
done
done
