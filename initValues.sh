#!/bin/sh
architecture=$(uname -m)

init_values()
{
    case $architecture in
        amd64|x86_64)
        # sed images list
        cp image-list/images-amd64.yaml tmp_images
            ;;
        aarch64|arm64)
        # sed images list
        cp image-list/images-arm64.yaml tmp_images
            ;;
        # not supported
        *)
        echo "[ERROR] this arch not supported"
        exit 1
            ;;
    esac
    sed -i 's/^/  /g' tmp_images
    echo "global:" >> helm-chart/values.yaml
    cat tmp_images >> helm-chart/values.yaml
    echo "global:" >> dbinit/values.yaml
    cat tmp_images >> dbinit/values.yaml
    rm tmp_images
}

init_values
