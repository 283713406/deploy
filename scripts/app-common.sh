#!/usr/bin/env bash
install-app-repo() {
    export node1Ip=$(get-nodeIp)
    helm install ${ARGS} -n apps repo application/repo/    \
        -f values/apps-values.yaml  -f ${IMAGELIST} \
        --set apps.repo.ip=${node1Ip} \
        -f values/global-values.yaml
}
lint-app-repo() {
    export node1Ip=$(get-nodeIp)
    helm lint ${ARGS} -n apps application/repo/   \
        -f values/apps-values.yaml  -f ${IMAGELIST} \
        -f values/global-values.yaml  --set apps.repo.ip=${node1Ip}
}
uninstall-app-repo() {
    helm uninstall ${ARGS} -n apps repo
}


install-app-softshop() {
    export node1Ip=$(get-nodeIp)
    helm install ${ARGS} -n apps softshop application/softshop/   \
        -f values/apps-values.yaml  -f ${IMAGELIST} -f values/global-values.yaml \
        --set apps.repo.ip=${node1Ip}
}
lint-app-softshop() {
    helm lint ${ARGS} -n apps application/softshop/ -f values/apps-values.yaml  \
        -f ${IMAGELIST} -f values/global-values.yaml --set apps.repo.ip=${node1Ip}
}
uninstall-app-softshop() {
    helm uninstall ${ARGS} -n apps softshop
}


install-app-tianyu() {
    export node1Ip=$(get-nodeIp)
    helm install ${ARGS} -n kcm tianyu application/tianyu/  \
        -f values/apps-values.yaml  -f ${IMAGELIST} -f values/global-values.yaml \
        --set apps.kcm.ip=${node1Ip} --set apps.mirrorsUpdate.ip=${node1Ip} \
        --set apps.softshop.ip=${node1Ip}
}
lint-app-tianyu() {
    helm lint ${ARGS} -n kcm application/tianyu/  \
        -f values/apps-values.yaml  -f ${IMAGELIST} \
        -f values/global-values.yaml
}
uninstall-app-tianyu() {
    helm uninstall ${ARGS} -n kcm tianyu
}


install-app-mirrors-update() {
    export node1Ip=$(get-nodeIp)
    helm install ${ARGS} -n apps mirrors-update application/mirrors-update \
        -f values/apps-values.yaml  -f ${IMAGELIST} -f values/global-values.yaml  \
        --set apps.kcm.ip=${node1Ip}
}
lint-app-mirrors-update() {
    helm lint ${ARGS} -n apps application/mirrors-update \
        -f values/apps-values.yaml  -f ${IMAGELIST} \
        -f values/global-values.yaml
}
uninstall-app-mirrors-update() {
    helm uninstall ${ARGS} -n apps mirrors-update
}


install-apps() {
    install-app-tianyu
    install-app-repo
    install-app-softshop
    install-app-mirrors-update
}
lint-apps() {
    lint-app-repo
    lint-app-tianyu
    lint-app-softshop
    lint-app-mirrors-update
}
uninstall-apps() {
    uninstall-app-tianyu
    uninstall-app-repo
    uninstall-app-softshop
    uninstall-app-mirrors-update
}

uninstall-all-pv-apps() {
    kubectl get pvc -n apps | awk '{print $1}' \
        | xargs -I '{}' kubectl delete -n apps pvc "{}" $1
    kubectl get pv | grep apps/ | awk '{print $1}' \
        | xargs -I '{}' kubectl delete  pv  "{}" $1
}
