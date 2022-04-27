#!/usr/bin/env bash


template-app-tianyu() {
    helm template ${ARGS}  application/tianyu/  \
        -f values/apps-values.yaml  -f ${IMAGELIST} \
        -f values/global-values.yaml > /tmp/tianyu.yaml
}


template-app-softshop() {
    helm template ${ARGS}  application/softshop/  \
        -f values/apps-values.yaml  -f ${IMAGELIST} \
        -f values/global-values.yaml > /tmp/softshop.yaml
}
