#!/usr/bin/env bash

lint-modules() {
    lint-module-certManager
    lint-module-maxscale
}
install-modules() {
    install-module-certManager
    install-module-maxscale
}
uninstall-modules() {
    uninstall-module-certManager
    uninstall-module-maxscale
}

lint-module-maxscale() {
    helm lint  ${ARGS}  -n module module/maxscale \
        -f values/module/maxscale-values.yaml  $GVALUE
}
install-module-maxscale() {
    helm install  ${ARGS}  -n module maxscale module/maxscale \
        -f values/module/maxscale-values.yaml $GVALUE
}
uninstall-module-maxscale() {
    helm uninstall -n module maxscale
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

