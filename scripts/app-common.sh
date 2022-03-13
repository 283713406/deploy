#!/usr/bin/env bash
install-app-repo() {
    helm install ${ARGS} -n app repo application/repo/
}
lint-app-repo() {
    helm lint ${ARGS} -n app application/repo/
}
uninstall-app-repo() {
    helm uninstall ${ARGS} -n app repo
}


install-app-softshop() {
    helm install ${ARGS} -n app repo application/softshop/

}
lint-app-softshop() {
    helm lint ${ARGS} -n app application/softshop/
}
uninstall-app-softshop() {
    helm uninstall ${ARGS} -n app repo softshop
}


install-app-tianyu() {
    helm install ${ARGS} -n app repo application/tianyu/
}
lint-app-tianyu() {
    helm lint ${ARGS} -n app application/tianyu/
}
uninstall-app-tianyu() {
    helm uninstall ${ARGS} -n app tianyu
}


install-app-mirrors-update() {
    helm install ${ARGS} -n app repo application/mirrors-update
}
lint-app-mirrors-update() {
    helm lint ${ARGS} -n app application/mirrors-update

}
uninstall-app-mirrors-update() {
    helm uninstall ${ARGS} -n app repo
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
