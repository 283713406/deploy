.PHONY: all pre-install  pre-uninstall

#IMAGELIST=image-list/images-arm64.yaml
#IMAGELIST=image-list/images-amd64.yaml
IMAGELIST=image-list/images_dev-arm64.yaml
#IMAGELIST=image-list/images_dev-amd64.yaml

ARCH:=$(shell uname -m)
ACTION=install

ifeq ($(ARCH),aarch64)
        DARCH:=arm64
endif

ifeq ($(ARCH), x86_64)
        DARCH:=amd64
endif

pre:
	kubectl create ns ha; \
	kubectl create ns apisix-system; \
	helm install pre pre-install/pre -f values.yaml -f ${IMAGELIST}; \
	kubectl delete pods --field-selector status.phase=Running,status.phase=Failed -n nfs-storage

pre-uninstall:
	helm uninstall pre

dbinit-install:
	helm install -n db dbinit pre-install/dbinit -f pre-install/dbinit/values.yaml -f values.yaml

dbinit-uninstall:
	helm uninstall -n db  dbinit


ha-all-install:
	helm install -n apisix-system apisix ha/apisix/ -f ha/apisix/values.yaml -f values.yaml -f ${IMAGELIST}; \
	helm install -n ha elastic ha/elasticsearch/ -f ha/elasticsearch/values.yaml -f values.yaml -f ${IMAGELIST}; \
	helm install -n ha etcd   ha/etcd/ -f ha/etcd/values.yaml -f values.yaml -f ${IMAGELIST}; \
	helm install -n ha minio  ha/minio/minio -f ha/minio/minio/values.yaml -f values.yaml -f ${IMAGELIST}; \
	helm install -n ha mongodb   ha/mongodb/ -f ha/mongodb/values.yaml -f values.yaml -f ${IMAGELIST}; \
	helm install -n ha mysql   ha/mysql/ -f ha/mysql/values.yaml -f values.yaml -f ${IMAGELIST}; \
	helm install -n ha postgres ha/postgres/ -f ha/postgres/values.yaml -f values.yaml -f ${IMAGELIST}; \
	helm install -n ha redis   ha/redis/ -f ha/redis/values.yaml -f values.yaml  -f ${IMAGELIST}

ha-all-uninstall:
	helm uninstall -n apisix-system apisix
	helm uninstall -n ha etcd  mongodb mysql postgres redis ;\
	helm uninstall -n ha elastic minio;\

list:
	helm list -A
