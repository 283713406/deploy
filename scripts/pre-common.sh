#!/usr/bin/env bash

install-pre() {
    kubectl create ns ha
    kubectl create ns kcm
    kubectl create ns apisix-system
    kubectl create ns apps

    kubectl create ns dbinit-postgres-repo
    kubectl create ns dbinit-mysql-tianyu
    kubectl create ns dbinit-mongodb-tianyu
    kubectl create ns dbinit-mysql-mirrors-update
    kubectl create ns dbinit-mysql-softshop

    helm install  ${ARGS}  pre pre-install/pre \
        -f values/apps-values.yaml -f ${IMAGELIST} -f values/global-values.yaml

    kubectl delete pods --field-selector  \
        status.phase=Running,status.phase=Failed -n nfs-storage
}
lint-pre() {
    helm lint  pre pre-install/pre -f values/apps-values.yaml \
        -f ${IMAGELIST} -f values/global-values.yaml
}
uninstall-pre() {
    helm uninstall pre
}

lint-dbinit(){
    helm lint  -n db dbinit pre-install/dbinit \
        -f pre-install/dbinit/values.yaml -f values/dbinit-values.yaml \
        -f ${IMAGELIST} -f values/global-values.yaml
}

# 创建初始化repo postgres数据的job
uninstall-dbinit-postgres-repo(){
    helm uninstall ${ARGS} -n dbinit-postgres-repo dbinit-postgres-repo
}
install-dbinit-postgres-repo() {

    helm list -A | grep dbinit-postgres-repo && \
        uninstall-dbinit-postgres-repo

    export PGPASSWORD=$(kubectl get secret  \
        postgres.acid-db.credentials.postgresql.acid.zalan.do \
        -o  'jsonpath={.data.password}' -n ha | base64  -d )

    helm install ${ARGS} -n dbinit-postgres-repo dbinit-postgres-repo  pre-install/dbinit \
        -f pre-install/dbinit/values.yaml -f values/dbinit-values.yaml -f ${IMAGELIST} \
        -f values/global-values.yaml  --set postgres.password=${PGPASSWORD} \
        --set postgres.enabled=true
}



# 创建初始化mirrors-update mysql数据的job
uninstall-dbinit-mysql-mirrors-update(){
    helm uninstall ${ARGS} -n dbinit-mysql-mirrors-update dbinit-mysql-mirrors-update
}
install-dbinit-mysql-mirrors-update() {
    helm list -A | grep dbinit-mysql-mirrors-update && \
        uninstall-dbinit-mysql-mirrors-update
    helm install ${ARGS} -n dbinit-mysql-mirrors-update dbinit-mysql-mirrors-update pre-install/dbinit \
        -f pre-install/dbinit/values.yaml -f values/dbinit-values.yaml -f ${IMAGELIST} \
        -f values/global-values.yaml --set mysql.enabled=true \
        --set mysql.init.mirrors_update.enabled=true
}


# 创建初始化softshop mysql数据的job
uninstall-dbinit-mysql-softshop(){
    helm uninstall ${ARGS} -n dbinit-mysql-softshop dbinit-mysql-softshop
}
install-dbinit-mysql-softshop() {
    helm list -A | grep dbinit-mysql-softshop && \
        uninstall-dbinit-mysql-softshop
    helm install ${ARGS} -n dbinit-mysql-softshop dbinit-mysql-softshop pre-install/dbinit \
        -f pre-install/dbinit/values.yaml -f values/dbinit-values.yaml -f ${IMAGELIST} \
        -f values/global-values.yaml --set mysql.enabled=true \
        --set mysql.init.softshop.enabled=true
}

# 创建初始化tianyu mysql数据的job
uninstall-dbinit-mysql-tianyu(){
    helm uninstall ${ARGS} -n dbinit-mysql-tianyu dbinit-mysql-tianyu
}
install-dbinit-mysql-tianyu() {
    helm list -A | grep dbinit-mysql-tianyu && \
        uninstall-dbinit-mysql-tianyu
    helm install ${ARGS} -n dbinit-mysql-tianyu dbinit-mysql-tianyu pre-install/dbinit \
        -f pre-install/dbinit/values.yaml -f values/dbinit-values.yaml -f ${IMAGELIST} \
        -f values/global-values.yaml --set mysql.enabled=true \
        --set mysql.init.kcm.enabled=true
}


# 创建初始化tianyu mongodb数据的job
uninstall-dbinit-mongodb-tianyu(){
    helm uninstall ${ARGS} -n dbinit-mongodb-tianyu dbinit-mongodb-tianyu
}
install-dbinit-mongodb-tianyu() {
    helm list -A | grep dbinit-mongodb-tianyu && \
        uninstall-dbinit-mongodb-tianyu
    helm install ${ARGS} -n dbinit-mongodb-tianyu dbinit-mongodb-tianyu pre-install/dbinit \
        -f pre-install/dbinit/values.yaml -f values/dbinit-values.yaml \
        -f ${IMAGELIST} -f values/global-values.yaml \
        --set mongodb.enabled=true
}



dbinit-list-job() {
    echo " namespace: dbinit-mysql-tianyu"
    kubectl get job -n dbinit-mysql-tianyu
    echo " namespace: dbinit-mongodb-tianyu"
    kubectl get job -n dbinit-mongodb-tianyu
    echo " namespace: dbinit-mysql-mirrors-update"
    kubectl get job -n dbinit-mysql-mirrors-update
    echo " namespace: dbinit-mysql-softshop"
    kubectl get job -n dbinit-mysql-softshop
}
dbinit-list-pods() {
    echo " namespace: dbinit-mysql-tianyu"
    kubectl get pods -n dbinit-mysql-tianyu
    echo " namespace: dbinit-mongodb-tianyu"
    kubectl get pods -n dbinit-mongodb-tianyu
    echo " namespace: dbinit-mysql-mirrors-update"
    kubectl get pods -n dbinit-mysql-mirrors-update
    echo " namespace: dbinit-mysql-softshop"
    kubectl get pods -n dbinit-mysql-softshop
}

install-dbinit-all() {
    install-dbinit-mysql-tianyu
    install-dbinit-mongodb-tianyu
    install-dbinit-mysql-mirrors-update
    install-dbinit-mysql-softshop
    install-dbinit-postgres-repo
}

uninstall-dbinit-all() {
    uninstall-dbinit-mysql-tianyu
    uninstall-dbinit-mongodb-tianyu
    uninstall-dbinit-mysql-mirrors-update
    uninstall-dbinit-mysql-softshop
    uninstall-dbinit-postgres-repo
}
