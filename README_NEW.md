# **新版部署方法** 

## 安装执行如下命令
前提条件必须k8s容器云平台已经就绪，然后再master节点上执行如下操作。

首先修改本目录下的values.yaml文件

``` bash
# 安装依赖文件和资源.
$ make pre

# 安装所有ha应用依赖组件
$ make ha-all-install

# 安装dbinit服务
$ make dbinit-install
```

## 卸载对应服务执行如下命令
``` bash
# 卸载依赖文件和资源.
$ make preuninstall

# 卸载所有ha应用依赖组件
$ make ha-all-uninstall

# 卸载dbinit服务
$ make dbinit-uninstall
```
