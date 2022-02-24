
cpath :
	sed -i 's#/k8s/nfs-storage/common#${Path}#g' nfs.yaml

chost :
	sed -i 's#HOST#${Host}#g' nfs.yaml

amd :
	sed -i 's/arm64/amd64/g' nfs.yaml

apply :
	kubectl apply -f nfs.yaml