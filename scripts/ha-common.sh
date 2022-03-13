#!/bin/bash -xe
check-ha-lint() {
    helm lint  -n apisix-system apisix ha/apisix/ -f ha/apisix/values.yaml -f values.yaml -f ${IMAGELIST}
    helm lint  -n ha elastic ha/elasticsearch/ -f ha/elasticsearch/values.yaml -f values.yaml -f ${IMAGELIST}
    helm lint  -n ha etcd   ha/etcd/ -f ha/etcd/values.yaml -f values.yaml -f ${IMAGELIST}
    helm lint  -n ha minio  ha/minio/minio -f ha/minio/minio/values.yaml -f values.yaml -f ${IMAGELIST}
    helm lint  -n ha mongodb   ha/mongodb/ -f ha/mongodb/values.yaml -f values.yaml -f ${IMAGELIST}
    helm lint  -n ha mysql   ha/mysql/ -f ha/mysql/values.yaml -f values.yaml -f ${IMAGELIST}
    helm lint  -n ha postgres ha/postgres/ -f ha/postgres/values.yaml -f values.yaml -f ${IMAGELIST}
    helm lint  -n ha redis   ha/redis/ -f ha/redis/values.yaml -f values.yaml  -f ${IMAGELIST}
}

install-pre() {
    kubectl create ns ha
    kubectl create ns apisix-system
    helm install  ${ARGS}  pre pre-install/pre -f values.yaml -f ${IMAGELIST}
    kubectl delete pods --field-selector status.phase=Running,status.phase=Failed -n nfs-storage
}
check-pre-lint() {
    helm lint  pre pre-install/pre -f values.yaml -f ${IMAGELIST}
    helm lint  -n db dbinit pre-install/dbinit -f pre-install/dbinit/values.yaml -f values.yaml -f ${IMAGELIST}
}
uninstall-pre() {
    helm uninstall pre
}


install-dbinit() {
    helm install  ${ARGS}  -n db dbinit pre-install/dbinit -f pre-install/dbinit/values.yaml -f values.yaml
}
uninstall-dbinit() {
    helm uninstall -n db  dbinit
}


list() {
    helm list -A
}


install-app-apisix() {
    helm install  ${ARGS}  -n apisix-system apisix ha/apisix/ -f ha/apisix/values.yaml -f values.yaml -f ${IMAGELIST}
}
lint-app-apisix() {
    helm lint  ${ARGS}  -n apisix-system ha/apisix/ -f ha/apisix/values.yaml -f values.yaml -f ${IMAGELIST}
}
uninstall-app-apisix() {
    helm uninstall  ${ARGS}  -n apisix-system apisix
}


install-app-elastic() {
    helm install  ${ARGS}  -n ha elastic ha/elasticsearch/ -f ha/elasticsearch/values.yaml -f values.yaml -f ${IMAGELIST}
}
lint-app-elastic() {
    helm lint  ${ARGS}  -n ha ha/elasticsearch/ -f ha/elasticsearch/values.yaml -f values.yaml -f ${IMAGELIST}
}
uninstall-app-elastic() {
    helm uninstall  ${ARGS}  -n ha elastic
}


install-app-etcd() {
    helm install  ${ARGS}  -n ha etcd   ha/etcd/ -f ha/etcd/values.yaml -f values.yaml -f ${IMAGELIST}
}
lint-app-etcd() {
    helm lint  ${ARGS}  -n ha ha/etcd/ -f ha/etcd/values.yaml -f values.yaml -f ${IMAGELIST}
}
uninstall-app-etcd() {
    helm uninstall  ${ARGS}  -n ha etcd
}


install-app-minio() {
    helm install  ${ARGS}  -n ha minio  ha/minio/minio -f ha/minio/minio/values.yaml -f values.yaml -f ${IMAGELIST}
}
lint-app-minio() {
    helm lint  ${ARGS}  -n ha ha/minio/minio -f ha/minio/minio/values.yaml -f values.yaml -f ${IMAGELIST}
}
uninstall-app-minio() {
    helm uninstall  ${ARGS}  -n ha minio
}


install-app-mongodb() {
    helm install  ${ARGS}  -n ha mongodb   ha/mongodb/ -f ha/mongodb/values.yaml -f values.yaml -f ${IMAGELIST}
}
lint-app-mongodb() {
    helm lint  ${ARGS}  -n ha ha/mongodb/ -f ha/mongodb/values.yaml -f values.yaml -f ${IMAGELIST}
}
uninstall-app-mongodb() {
    helm uninstall  ${ARGS}  -n ha mongodb
}


install-app-mysql() {
    helm install  ${ARGS}  -n ha mysql   ha/mysql/ -f ha/mysql/values.yaml -f values.yaml -f ${IMAGELIST}
}
lint-app-mysql() {
    helm lint  ${ARGS}  -n ha ha/mysql/ -f ha/mysql/values.yaml -f values.yaml -f ${IMAGELIST}
}
uninstall-app-mysql() {
    helm uninstall  ${ARGS}  -n ha mysql
}


install-app-postgres() {
    helm install  ${ARGS}  -n ha postgres ha/postgres/ -f ha/postgres/values.yaml -f values.yaml -f ${IMAGELIST}
}
lint-app-postgres() {
    helm lint  ${ARGS}  -n ha ha/postgres/ -f ha/postgres/values.yaml -f values.yaml -f ${IMAGELIST}
}
uninstall-app-postgres() {
    helm uninstall  ${ARGS}  -n ha postgres
}


install-app-redis() {
    helm install  ${ARGS}  -n ha redis   ha/redis/ -f ha/redis/values.yaml -f values.yaml  -f ${IMAGELIST}
}
lint-app-redis() {
    helm lint  ${ARGS}  -n ha ha/redis/ -f ha/redis/values.yaml -f values.yaml  -f ${IMAGELIST}
}
uninstall-app-redis() {
    helm uninstall  ${ARGS}  -n ha redis
}


install-ha() {
    install-app-apisix
    install-app-elastic
    install-app-etcd
    install-app-minio
    install-app-mongodb
    install-app-mysql
    install-app-postgres
    install-app-redis
}
uninstall-ha() {
    uninstall-app-apisix
    uninstall-app-elastic
    uninstall-app-etcd
    uninstall-app-minio
    uninstall-app-mongodb
    uninstall-app-mysql
    uninstall-app-postgres
    uninstall-app-redis
}
lint-ha() {
    lint-app-apisix
    lint-app-elastic
    lint-app-etcd
    lint-app-minio
    lint-app-mongodb
    lint-app-mysql
    lint-app-postgres
    lint-app-redis
}
