#!/bin/bash -xe
lint-has() {
    helm lint  -n apisix-system  apisix     ha/apisix/ -f ha/apisix/values.yaml \
        -f values/apisix-values.yaml -f ${IMAGELIST} -f values/global-values.yaml

    helm lint  -n ha             elastic    ha/elasticsearch/ -f ha/elasticsearch/values.yaml \
        -f values/elastic-values.yaml -f ${IMAGELIST} -f values/global-values.yaml

    helm lint  -n ha             etcd       ha/etcd/ -f ha/etcd/values.yaml \
        -f values/etcd-values.yaml -f ${IMAGELIST} -f values/global-values.yaml

    helm lint  -n ha             minio      ha/minio/minio -f ha/minio/minio/values.yaml \
        -f values/minio-values.yaml -f ${IMAGELIST} -f values/global-values.yaml

    helm lint  -n ha             mongodb    ha/mongodb/ -f ha/mongodb/values.yaml \
        -f values/mongodb-values.yaml -f ${IMAGELIST} -f values/global-values.yaml

    helm lint  -n ha             mysql      ha/mysql/ -f ha/mysql/values.yaml  \
        -f values/mysql-values.yaml -f ${IMAGELIST} -f values/global-values.yaml

    helm lint  -n ha             postgres   ha/postgres/ -f ha/postgres/values.yaml \
        -f values/postgres-values.yaml -f ${IMAGELIST} -f values/global-values.yaml

    helm lint  -n ha             redis      ha/redis/ -f ha/redis/values.yaml \
        -f values/redis-values.yaml  -f ${IMAGELIST} -f values/global-values.yaml
}


install-dbinit() {
    helm install  ${ARGS}  -n db dbinit pre-install/dbinit \
        -f pre-install/dbinit/values.yaml -f values/global-values.yaml
}
uninstall-dbinit() {
    helm uninstall -n db  dbinit
}


list() {
    helm list -A
}


install-ha-apisix() {
    helm install  ${ARGS}  -n apisix-system apisix ha/apisix/ \
        -f ha/apisix/values.yaml -f values/apisix-values.yaml \
        -f ${IMAGELIST} -f values/global-values.yaml
}
lint-ha-apisix() {
    helm lint  ${ARGS}  -n apisix-system ha/apisix/ \
        -f ha/apisix/values.yaml -f values/apisix-values.yaml \
        -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-ha-apisix() {
    helm uninstall  ${ARGS}  -n apisix-system apisix
}


install-ha-elastic() {
    helm install  ${ARGS}  -n ha elastic ha/elasticsearch/ \
        -f ha/elasticsearch/values.yaml -f values/elastic-values.yaml \
        -f ${IMAGELIST} -f values/global-values.yaml
}
lint-ha-elastic() {
    helm lint  ${ARGS}  -n ha ha/elasticsearch/ -f ha/elasticsearch/values.yaml \
        -f values/elastic-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-ha-elastic() {
    helm uninstall  ${ARGS}  -n ha elastic
}


install-ha-etcd() {
    helm install  ${ARGS}  -n ha etcd   ha/etcd/ -f ha/etcd/values.yaml \
        -f values/etcd-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
lint-ha-etcd() {
    helm lint  ${ARGS}  -n ha ha/etcd/ -f ha/etcd/values.yaml \
        -f values/etcd-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-ha-etcd() {
    helm uninstall  ${ARGS}  -n ha etcd
}


install-ha-minio() {
    helm install  ${ARGS}  -n ha minio  ha/minio/minio -f ha/minio/minio/values.yaml \
        -f values/minio-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
lint-ha-minio() {
    helm lint  ${ARGS}  -n ha ha/minio/minio -f ha/minio/minio/values.yaml \
        -f values/minio-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-ha-minio() {
    helm uninstall  ${ARGS}  -n ha minio
}


install-ha-mongodb() {
    helm install  ${ARGS}  -n ha mongodb   ha/mongodb/ -f ha/mongodb/values.yaml \
        -f values/mongodb-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
lint-ha-mongodb() {
    helm lint  ${ARGS}  -n ha ha/mongodb/ -f ha/mongodb/values.yaml \
        -f values/mongodb-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-ha-mongodb() {
    helm uninstall  ${ARGS}  -n ha mongodb
}


install-ha-mysql() {
    helm install  ${ARGS}  -n ha mysql   ha/mysql/ -f ha/mysql/values.yaml \
        -f values/mysql-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
lint-ha-mysql() {
    helm lint  ${ARGS}  -n ha ha/mysql/ -f ha/mysql/values.yaml \
        -f values/mysql-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-ha-mysql() {
    helm uninstall  ${ARGS}  -n ha mysql
}


install-ha-postgres() {
    helm install  ${ARGS}  -n ha postgres ha/postgres/ -f ha/postgres/values.yaml \
        -f values/postgres-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
lint-ha-postgres() {
    helm lint  ${ARGS}  -n ha ha/postgres/ -f ha/postgres/values.yaml \
        -f values/postgres-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-ha-postgres() {
    helm uninstall  ${ARGS}  -n ha postgres
}


install-ha-redis() {
    helm install  ${ARGS}  -n ha redis   ha/redis/ -f ha/redis/values.yaml \
        -f values/redis-values.yaml  -f ${IMAGELIST} -f values/global-values.yaml
}
lint-ha-redis() {
    helm lint  ${ARGS}  -n ha ha/redis/ -f ha/redis/values.yaml \
        -f values/redis-values.yaml  -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-ha-redis() {
    helm uninstall  ${ARGS}  -n ha redis
}


install-has() {
    install-ha-apisix
    install-ha-elastic
    install-ha-etcd
    install-ha-minio
    install-ha-mongodb
    install-ha-mysql
    install-ha-postgres
    install-ha-redis
}
uninstall-has() {
    uninstall-ha-apisix
    uninstall-ha-elastic
    uninstall-ha-etcd
    uninstall-ha-minio
    uninstall-ha-mongodb
    uninstall-ha-mysql
    uninstall-ha-postgres
    uninstall-ha-redis
}
lint-has() {
    lint-ha-apisix
    lint-ha-elastic
    lint-ha-etcd
    lint-ha-minio
    lint-ha-mongodb
    lint-ha-mysql
    lint-ha-postgres
    lint-ha-redis
}
