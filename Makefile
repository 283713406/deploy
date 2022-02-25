
cpath :
	sed -i 's#/k8s/nfs-storage/common#${Path}#g' nfs.yaml

chost :
	sed -i 's#HOST#${Host}#g' nfs.yaml

amd :
	sed -i 's#registry.kylincloud.org:4001/solution/tianyu/arm64/nfs-client-provisioner-arm64:20220217#registry.kylincloud.org:4001/solution/tianyu/amd64/nfs-client-provisioner:20220217#g' nfs.yaml

apply :
	kubectl apply -f nfs.yaml