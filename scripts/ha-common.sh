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

    helm lint  -n ha             redis      ha/redis/ -f ha/redis/values.yaml \
        -f values/redis-values.yaml  -f ${IMAGELIST} -f values/global-values.yaml

    helm lint  -n ha             radius      ha/radius/ -f ha/radius/values.yaml \
        -f values/radius-values.yaml  -f ${IMAGELIST} -f values/global-values.yaml

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


install-ha-radius() {
    helm install  ${ARGS}  -n ha radius   ha/radius/ -f ha/radius/values.yaml \
        -f values/radius-values.yaml  -f ${IMAGELIST} -f values/apps-values.yaml -f values/global-values.yaml
}
upgrade-ha-radius() {
    helm upgrade  ${ARGS}  -n ha radius   ha/radius/ -f ha/radius/values.yaml \
        -f values/radius-values.yaml  -f ${IMAGELIST} -f values/apps-values.yaml -f values/global-values.yaml
}
lint-ha-radius() {
    helm lint  ${ARGS}  -n ha ha/radius/ -f ha/radius/values.yaml \
        -f values/radius-values.yaml  -f ${IMAGELIST} -f values/apps-values.yaml -f values/global-values.yaml
}
uninstall-ha-radius() {
    helm uninstall  ${ARGS}  -n ha radius
}



install-has() {
    kubectl create ns ha
    install-ha-elastic
    install-ha-etcd
    install-ha-minio
    install-ha-mongodb
    install-ha-mysql
    install-ha-redis
    install-ha-radius
}
uninstall-has() {
    uninstall-ha-elastic
    uninstall-ha-etcd
    uninstall-ha-minio
    uninstall-ha-mongodb
    uninstall-ha-mysql
    uninstall-ha-redis
    uninstall-ha-radius
    kubectl delete ns ha
}
lint-has() {
    lint-ha-elastic
    lint-ha-etcd
    lint-ha-minio
    lint-ha-mongodb
    lint-ha-mysql
    lint-ha-redis
    lint-ha-radius
}

uninstall-all-pv-ha() {
    kubectl get pvc -n ha | awk '{print $1}' \
        | xargs -I '{}' kubectl delete -n ha pvc "{}" $1
    kubectl get pv | grep ha/ | awk '{print $1}' \
        | xargs -I '{}' kubectl delete  pv  "{}" $1
}
