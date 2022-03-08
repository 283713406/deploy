.PHONY: all nfs clean

ARCH:=$(shell uname -m)
ACTION=install

ifeq ($(ARCH),aarch64)
        DARCH:=arm64
endif

ifeq ($(ARCH), x86_64)
        DARCH:=amd64
endif

pre:
	helm install pre pre-install/pre -f values.yaml -f image-list/images-$(DARCH); \
	kubectl delete pods --field-selector status.phase=Running,status.phase=Failed -n nfs-storage

dbinit-install:
	helm install -n db dbinit pre-install/dbinit -f pre-install/dbinit/values.yaml -f values.yaml

dbinit-uninstall:
	helm uninstall -n db  dbinit

ha-all-install:
	helm install -n ha apisix ha/apisix/ -f ha/apisix/values.yaml -f values.yaml; \
	helm install -n ha elasti ha/elasticsearch/ -f ha/elasticsearch/values.yaml -f values.yaml; \
	helm install -n ha etcd   ha/etcd/ -f ha/etcd/values.yaml -f values.yaml; \
	helm install -n ha minio  ha/minio/ -f ha/minio/values.yaml -f values.yaml; \
	helm install -n ha mongodb   ha/mongodb/ -f ha/mongodb/values.yaml -f values.yaml; \
	helm install -n ha mysql   ha/mysql/ -f ha/mysql/values.yaml -f values.yaml; \
	helm install -n ha postgres ha/postgres/ -f ha/postgres/values.yaml -f values.yaml; \
	helm install -n ha redis   ha/redis/ -f ha/redis/values.yaml -f values.yaml

ha-all-uninstall:
	helm uninstall -n ha apisix elastic etcd  minio mongodb mysql postgres redis
