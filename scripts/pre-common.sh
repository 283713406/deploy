#!/usr/bin/env bash

install-pre() {
    kubectl create ns ha
    kubectl create ns kcm
    kubectl create ns apisix-system
    kubectl create ns apps
    helm install  ${ARGS}  pre pre-install/pre -f values.yaml -f ${IMAGELIST}
    kubectl delete pods --field-selector status.phase=Running,status.phase=Failed -n nfs-storage
}
lint-pre() {
    helm lint  pre pre-install/pre -f values.yaml -f ${IMAGELIST}
    helm lint  -n db dbinit pre-install/dbinit -f pre-install/dbinit/values.yaml -f values.yaml -f ${IMAGELIST}
}
uninstall-pre() {
    helm uninstall pre
}
