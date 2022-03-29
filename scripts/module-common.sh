#!/usr/bin/env bash

lint-modules() {
    lint-module-certManager
}
install-modules() {
    install-module-certManager
}
uninstall-modules() {
    uninstall-module-certManager
}



lint-module-certManager() {
    helm lint  ${ARGS}  -n module module/cert-manager \
        -f values/module/cert-manager.yaml  $GVALUE
}
install-module-certManager() {
    helm install  ${ARGS}  -n module cert-manager module/cert-manager \
        -f values/module/cert-manager.yaml $GVALUE
}
uninstall-module-certManager() {
    helm uninstall -n module cert-manager
}

