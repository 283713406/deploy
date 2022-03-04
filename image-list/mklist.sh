> images-amd64.yaml
> images-arm64.yaml
> images_dev-amd64.yaml
> images_dev-arm64.yaml

for ARCH in amd64 arm64;do

echo ========= images-${ARCH}.yml ========
echo images: >images-${ARCH}.yaml
cat ${ARCH} | while read line; do echo $line |grep harbor >/dev/null && {
   echo $line | sed 's=-'${ARCH}'==g' | awk -F'/' '{print "registry.kylincloud.org:4001/solution/"$2"/'${ARCH}'/"$NF}' | sed 's=solution-==g'
} || echo "$line" | sed 's=-'${ARCH}'==g'; done | sort | while read product; do
    key=$(echo ${product} | awk -F'/|:' '{print $(NF-1)}' | sed 's=-'${ARCH}'==g'| sed 's=-12==g' | sed 's=-[a-z]=\U&=g' | sed 's=-==g')
    value=$product;

    echo -e "$key:\t\t$value" | awk '{printf "  %-30s\"%-15s\"\n",$1,$2}' >>images-${ARCH}.yaml
    echo -e "$key:\t\t$value" | awk '{printf "  %-30s\"%-15s\"\n",$1,$2}'
done 

echo ======= images_dev-${ARCH}.yml =======
echo images: >images_dev-${ARCH}.yaml
cat ${ARCH} | while read line; do

key=$(echo $line | awk -F'/|:' '{print $(NF-1)}' | sed 's=-'${ARCH}'==g' | sed 's=-12==g' | sed 's=-[a-z]=\U&=g' | sed 's=-==g')
value=$line;

echo -e "$key:\t\t$value" | awk '{printf "  %-30s\"%-15s\"\n",$1,$2}';

done >images_dev-${ARCH}.yaml

done
