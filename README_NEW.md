# **新版部署方法** 

## 安装执行如下命令
前提条件必须k8s容器云平台已经就绪，然后再master节点上执行如下操作。

首先修改本目录下的values.yaml文件

首先执行:
```bash
$ source install.sh
```

然后执行如下:
``` bash
# 安装依赖文件和资源.
$ install-pre

# 安装所有ha应用依赖组件
$ install-ha
```

然后进行如下:
```bash
# 安装所有应用
$ install-apps
```

## 卸载对应服务执行如下命令
``` bash
# 卸载依赖文件和资源.
$ uninstall-pre

# 卸载所有ha应用依赖组件
$ uninstall-ha

# 卸载dbinit服务
$ uninstall-dbinit
```
