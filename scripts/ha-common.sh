#!/bin/bash -xe
lint-has() {

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


install-ha-elastic() {
    helm install  ${ARGS}  -n ha elastic ha/elasticsearch/ \
        -f ha/elasticsearch/values.yaml -f values/elastic-values.yaml \
        -f ${IMAGELIST} -f values/global-values.yaml
}
upgrade-ha-elastic() {
    helm upgrade  ${ARGS}  -n ha elastic ha/elasticsearch/ \
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
upgrade-ha-etcd() {
    helm upgrade  ${ARGS}  -n ha etcd   ha/etcd/
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
upgrade-ha-minio() {
    helm upgrade  ${ARGS}  -n ha minio  ha/minio/minio -f ha/minio/minio/values.yaml \
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
upgrade-ha-mongodb() {
    helm upgrade  ${ARGS}  -n ha mongodb   ha/mongodb/ -f ha/mongodb/values.yaml \
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
upgrade-ha-mysql() {
    helm upgrade  ${ARGS}  -n ha mysql   ha/mysql/ -f ha/mysql/values.yaml \
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
upgrade-ha-postgres() {
    helm upgrade  ${ARGS}  -n ha postgres ha/postgres/ -f ha/postgres/values.yaml \
        -f values/postgres-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
lint-ha-postgres() {
    helm lint  ${ARGS}  -n ha ha/postgres/ -f ha/postgres/values.yaml \
        -f values/postgres-values.yaml -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-ha-postgres() {
    helm uninstall -n ha ${ARGS} postgres
    kubectl delete -n ha sts acid-db
    kubectl delete -n ha svc acid-db acid-db-config acid-db-repl
    kubectl delete -n ha poddisruptionbudgets.policy postgres-acid-db-pdb
    kubectl delete -n ha pvc pgdata-acid-db-0 pgdata-acid-db-1 pgdata-acid-db-2
}


install-ha-redis() {
    helm install  ${ARGS}  -n ha redis   ha/redis/ -f ha/redis/values.yaml \
        -f values/redis-values.yaml  -f ${IMAGELIST} -f values/global-values.yaml
}
upgrade-ha-redis() {
    helm upgrade  ${ARGS}  -n ha redis   ha/redis/ -f ha/redis/values.yaml \
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
    kubectl create ns ha
    install-ha-elastic
    install-ha-etcd
    install-ha-minio
    install-ha-mongodb
    install-ha-mysql
    install-ha-postgres
    install-ha-redis
}
uninstall-has() {
    uninstall-ha-elastic
    uninstall-ha-etcd
    uninstall-ha-minio
    uninstall-ha-mongodb
    uninstall-ha-mysql
    uninstall-ha-postgres
    uninstall-ha-redis
    kubectl delete ns ha
}
lint-has() {
    lint-ha-elastic
    lint-ha-etcd
    lint-ha-minio
    lint-ha-mongodb
    lint-ha-mysql
    lint-ha-postgres
    lint-ha-redis
}

uninstall-all-pv-ha() {
    kubectl get pvc -n ha | awk '{print $1}' \
        | xargs -I '{}' kubectl delete -n ha pvc "{}" $1
    kubectl get pv | grep ha/ | awk '{print $1}' \
        | xargs -I '{}' kubectl delete  pv  "{}" $1
}
