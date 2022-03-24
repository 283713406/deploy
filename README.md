# **新版部署方法**

## 注意

所有命令和文件修改都在提供的安装脚本目录deploy下，不能在其他目录下操作。
除非文档中明确指定另有手册指导.
确保控制节点为3个，且hostname分别为master1、master2、master3
否则etcd会出现pending，如果控制节点hostname命名不同，
请联系开发，需要另外修改配置.

## 安装准备工作

前提条件必须k8s容器云平台已经就绪，然后再master节点上执行如下操作。

请先根据文档(待补充)安装并配置nfs服务.

如果需要部署安全管控，请先根据文档(待补充)安装并配置kim服务.

首先执行如下命令获取对应的ip地址,该ip是后续配置的hosts的ip
$ get-nodeIp

首先修改本目录下的values.yaml文件

```bash
# 修改server的值为nfs服务的ip, path为对应的nfs目录
$ vim values/global-values.yaml

# 修改apps.kcm.uri为配置的安全管控域名,假设配置为kcm.kylin.com
# 需要访问安全管控服务的终端机器需要配置该域名的host,对应ip为get-nodeIp获取的值.
$ vim values/apps-values.yaml

# 修改apps.kim.uri为配置的kim服务域名
# 需要访问安全管控服务的终端机器需要配置该域名的host,对应ip为kim服务的ip地址
# 修改apps.kim.password,apps.kim.username为配置的kim访问账号和密码
$ vim values/apps-values.yaml


# 需要访问软件商店的终端需要配置如下域名的hosts解析.
# krmp-repo.kylinserver.com
# krmp-manage.kylinserver.com
# krmp.kylinserver.com
# 配置ip为如下get-nodeIp获取的值
```

## 安装对应程序

所有命令都需在提供的deploy目录下执行，不能在其他目录执行下面命令。

初始执行如下:

```bash
$ source install.sh
```

然后执行:

```bash
# 安装依赖文件和资源.
$ install-pre

# 安装所有ha应用依赖组件
$ install-has
```

```bash
# 然后执行如下命令进行数据库初始化:

# 如果需要安装安全管控，请执行如下命令
$ install-dbinit-mysql-tianyu
$ install-dbinit-mongodb-tianyu

# 如果需要安装源更新服务，请执行如下命令
$ install-dbinit-mysql-mirrors-update

# 如果需要安装软件商店，请执行如下命令
$ install-dbinit-mysql-softshop

# 如果需要安装仓库源，请执行如下命令
$ install-dbinit-postgres-repo

然后执行如下命令:
$ dbinit-list-job
显示类似如下:
 namespace: dbinit-mysql-tianyu
NAME        COMPLETIONS   DURATION   AGE
mysql-job   1/1           13s        20m
.....

请确认所有的COMPLETIONS字段都为1/1,此时数据库数据初始化完毕.
请继续执行之后命令.
```

然后进行如下命令安装对应应用:

```bash
# 如果需要安装安全管控，请执行如下命令
$ install-app-tianyu

# 如果需要安装仓库源，请执行如下命令
$ install-app-repo

# 如果需要安装软件商店，请执行如下命令
$ install-app-softshop

# 如果需要安装源更新服务，请执行如下命令
$ install-app-mirrors-update
```

## 卸载对应服务执行如下命令

```bash
# 卸载依赖文件和资源.
$ uninstall-pre

# 卸载所有ha应用依赖组件
$ uninstall-has

# 卸载所有应用
$ uninstall-apps

# 一键卸载所有
# uninstall-all
```

## 参考验证访问方式

### apisix场景访问方式

``` bash
# 需要配置相关hosts
使用get-nodeIp命令可以获取nodeIp

vim /etc/hosts

# 验证安全管控需添加如下内容
<nodeIp>  kcm.kylinserver.com  # 这里的域名为 #3.1修改配置 中填写的域名

# 验证仓库源需添加如下内容
<nodeIp>  krmp.repo.kylinserver.com
<nodeIp>  krmp-repo.repo.kylinserver.com
<nodeIp>  krmp-manage.repo.kylinserver.com
<nodeIp>  krmp.kylinserver.com

# 验证软件商店需添加如下内容
<nodeIp>  apps.kylinserver.com

# 验证源更新软件需添加如下内容
<nodeIp>  kylin-update.kylinserver.com
```

#### 天域安全管控
浏览器直接访问:
https://kcm.kylinserver.com:30233/
使用激活码激活后，默认账号密码为 admin/Kcm.2021
#### 仓库源
浏览器直接访问:
http://krmp.kylinserver.com:30233/
管理员账号密码为 admin/123123
#### 软件商店
浏览器直接访问:
http://apps.kylinserver.com:30233/login
默认账号密码: safety/1234qwer
#### 源更新软件
http浏览器直接访问：
http://kylin-update.kylinserver.com:30233/dist/
https浏览器直接访问，注意替换nodeIP
https://nodeIp:30784/dist/
默认初始化登录账号root/123456


### 非apisix场景访问方式

下面的get-nodeIp字段指代在命令行中执行该命令获取的ip地址.
#### 天域安全管控
浏览器直接访问:
https://kcm.kylin.com:30443
#### 仓库源
浏览器直接访问:
下面默认账号:  admin/123123
http://krmp.repo.kylinserver.com

下面默认账号:  admin/123123
http://krmp-repo.repo.kylinserver.com

http://krmp-manage.repo.kylinserver.com
#### 软件商店
浏览器直接访问
http://get-nodeIp:30008
默认账号密码: admin/admin
#### 源更新软件
浏览器直接访问:
http://get-nodeIp:30780/dist/
https://get-nodeIp:30784/dist/
默认初始化登录账号root/123456
