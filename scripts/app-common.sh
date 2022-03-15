#!/usr/bin/env bash
install-app-repo() {
    helm install ${ARGS} -n apps repo application/repo/    -f values.yaml  -f ${IMAGELIST}
}
lint-app-repo() {
    helm lint ${ARGS} -n apps application/repo/   -f values.yaml  -f ${IMAGELIST} \
        --set frontResolvIp=${node1Ip} -set repostoreResolvIp=${node1Ip}
}
uninstall-app-repo() {
    helm uninstall ${ARGS} -n apps repo
}


install-app-softshop() {
    helm install ${ARGS} -n apps repo application/softshop/   -f values.yaml  -f ${IMAGELIST} \
        --set minioIp=${node1Ip} --set repoIp=${node1Ip}
}
lint-app-softshop() {
    helm lint ${ARGS} -n apps application/softshop/ -f values.yaml  -f ${IMAGELIST}
}
uninstall-app-softshop() {
    helm uninstall ${ARGS} -n apps repo softshop
}


install-app-tianyu() {
    helm install ${ARGS} -n apps tianyu application/tianyu/  -f values.yaml  -f ${IMAGELIST}
}
lint-app-tianyu() {
    helm lint ${ARGS} -n apps application/tianyu/  -f values.yaml  -f ${IMAGELIST}
}
uninstall-app-tianyu() {
    helm uninstall ${ARGS} -n apps tianyu
}


install-app-mirrors-update() {
    helm install ${ARGS} -n apps repo application/mirrors-update \
        -f values.yaml  -f ${IMAGELIST}  \
        --set tianYuUrl=${node1Ip}
}
lint-app-mirrors-update() {
    helm lint ${ARGS} -n apps application/mirrors-update  -f values.yaml  -f ${IMAGELIST}

}
uninstall-app-mirrors-update() {
    helm uninstall ${ARGS} -n apps repo
}


install-apps() {
    install-app-repo
    install-app-tianyu
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
    uninstall-app-repo
    uninstall-app-tianyu
    uninstall-app-softshop
    uninstall-app-mirrors-update
}
