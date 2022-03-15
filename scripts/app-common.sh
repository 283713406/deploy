#!/usr/bin/env bash
install-app-repo() {
    helm install ${ARGS} -n apps repo application/repo/    -f values/apps-values.yaml  -f ${IMAGELIST}
}
lint-app-repo() {
    helm lint ${ARGS} -n apps application/repo/   -f values/apps-values.yaml  -f ${IMAGELIST} \
        --set frontResolvIp=${node1Ip} -set repostoreResolvIp=${node1Ip}
}
uninstall-app-repo() {
    helm uninstall ${ARGS} -n apps repo
}


install-app-softshop() {
    helm install ${ARGS} -n apps softshop application/softshop/   -f values/apps-values.yaml  -f ${IMAGELIST} \
        --set minioIp=${node1Ip} --set repoIp=${node1Ip}
}
lint-app-softshop() {
    helm lint ${ARGS} -n apps application/softshop/ -f values/apps-values.yaml  -f ${IMAGELIST}
}
uninstall-app-softshop() {
    helm uninstall ${ARGS} -n apps softshop
}


install-app-tianyu() {
    helm install ${ARGS} -n apps tianyu application/tianyu/  \
        -f values/apps-values.yaml  -f ${IMAGELIST} \
        --set kcm.ip=${node1Ip} --set apps.mirrorsUpdate.ip=${node1Ip} \
        --set apps.uksc.ip=${node1Ip}
    kubectl delete  ValidatingWebhookConfiguration  ingress-nginx-admission-kcm-nginx-ingress
}
lint-app-tianyu() {
    helm lint ${ARGS} -n apps application/tianyu/  -f values/apps-values.yaml  -f ${IMAGELIST}
}
uninstall-app-tianyu() {
    helm uninstall ${ARGS} -n apps tianyu
}


install-app-mirrors-update() {
    helm install ${ARGS} -n apps mirrors-update application/mirrors-update \
        -f values/apps-values.yaml  -f ${IMAGELIST}  \
        --set tianYuUrl=${node1Ip}
}
lint-app-mirrors-update() {
    helm lint ${ARGS} -n apps application/mirrors-update  -f values/apps-values.yaml  -f ${IMAGELIST}
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
