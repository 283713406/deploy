# deploy

### 涉及操作介绍
```bash
# 本安装方法通过helm工具来进行安装，-n后的参数代表组件安装所在的命名空间，hacomponent为组件名字，./代表安装组件的配置文件所在目录.
# 注：同一个命名空间下组件名字不可重复
$ helm install -n ha hacomponent ./

# 从平台层面删除通过helm安装的组件，下面命令会卸载组件。
# 卸载后可以重新使用上面install命令安装，更新values或者其他文件后可以先uninstall然后再install.
# uninstall后需要一点时间等待组件彻底卸载(30s-60s)，未完全卸载时install会报namespace正在停止中
# 只要再uninstall后重新install即可。
$ helm -n ha uninstall hacomponent
```

整合部署应用软件及高可用软件，部署的前提条件是k8s集群已经就绪。服务的部署顺序是：
* a. KIM部署、NFS部署（*包含2.1与2.2步骤*），这两个服务可以分别同步进行部署
* b. 基础组件部署
* c. 仓库源部署、安全管控部署、软件商店部署、源更新部署，这四个服务可以分别同步进行部署

> a步骤是b,c步骤的基础，需预先部署；b步骤是c步骤的基础，需预先部署

### 前提条件
请先确认所有节点上均可连接
$ ping registry.kylincloud.org
# 测试registry镜像服务是否就绪,测试环境下会报权限问题(这是正常的)，用户现场环境会直接拉取,注意把下面 amd64 改成对应架构类型
$ docker pull  registry.kylincloud.org:4001/solution/ha/mongodb/amd64/mongo:4.4.2

测试失败，请在所有master和node节点的/etc/hosts文件中配置正确的registry.kylincloud.org地址。

### <sapn id="j1">1. KIM部署</sapn>
请参考[KIM部署](docs/01-kim-installation.md)

### <sapn id="j2">2 NFS部署</span>
####  2.1 nfs服务部署
请参考[NFS 部署](docs/02-nfs-installation.md)

####  2.2 nfs-storageClass部署
**切换到master1控制节点**
```bash
$ ssh root@master1
```
```bash
$ git clone https://gitlab.kylincloud.org/solution/deploy.git
$ cd deploy
# 必要: 修改nfs 服务地址，值为:步骤2.1 NFS部署中的NFS服务IP地址
$ make chost Host="192.168.1.1"

# 可选: 修改nfs 服务挂载目录，值为:步骤2.1 NFS部署中的NFS目录
$ make cpath Path="/foo/bar"

# 可选: 若部署的环境为x86环境，则执行下述操作，为arm64环境则无需操作
$ make amd
# 如果上述3个步骤误操作，执行下面这句命令重置nfs配置，再重新执行上述3个步骤
$ git checkout nfs.yaml

# 必要: 部署nfs
$ make apply
```

### <span id="j3">3 基础组件部署</span>
**切换到master1控制节点**
```bash
$ ssh root@master1
```
```bash
# 再次切换到之前的deploy目录
$ cd deploy
# 更新git submodule
$ git submodule update --init --recursive

#进入项目helm-chart目录
$ cd helm-chart

# 更新helm subchart
$ helm dependency update

# 若部署的环境为x86环境，则执行下述操作，为arm64环境则无需操作
$ sed -i 's/arm64/amd64/g' values.yaml

# 部署apisix
# 新建命名空间，命名空间为 apisix-system
$ kubectl create ns apisix-system
$ helm install -n apisix-system apisix --set mysql.enabled=false --set elasticsearch.enabled=false --set apisix.enabled=true --set mongodb.enabled=false --set redis-ha.enabled=false --set minio.enabled=false ./
# 查看所有pod是否Running
$ kubectl -n apisix-system get pods -o wide

# 部署剩余组件
# 新建命名空间，命名空间为 ha
$ kubectl create ns ha
$ helm install -n ha ha ./
# 查看所有pod是否Running
$ kubectl -n ha get pods -o wide
```
### 4 部署dbinit
部署dbinit对数据库进行初始化，执行创建数据库、表格、初始数据等操作。
注意该操作原则上在ha数据库部署之后只能执行一遍，重复执行可能导致问题。

切换到master1控制节点
```$ ssh root@master1```
请参考[dbinit](docs/03-db-init.md)

### 5 部署应用
#### 5.1 仓库源部署
**切换到master1控制节点**
```bash
$ ssh root@master1
```
```bash
#执行如下命令后将storageclass.kubernetes.io/is-default-class: "true"值改为：
#storageclass.kubernetes.io/is-default-class: "false"，输入wq保存退出
```bash
$ kubectl edit sc/local-path

$ git clone https://gitlab.kylincloud.org/solution/repo.git
#后续部署请 联系 曹远志 支持
```    

#### 5.2 安全管控部署
**切换到master1控制节点**
```bash
$ ssh root@master1
```
```bash
$ git clone https://gitlab.kylincloud.org/solution/tianyu.git
  # 请参考对应的values.yaml和文档。
$ helm install tianyu tianyu/
```

#### 5.3 软件商店部署
切换到master1控制节点```$ ssh root@master1```,请参考[软件商店](docs/04-softshop-installation.md)

#### 5.4 源更新部署
```bash
  # 切换到master1控制节点
$ ssh root@master1
$ git clone https://gitlab.kylincloud.org/solution/mirrors-update.git
  # 请参考对应的values.yaml和文档。
$ helm -n kylin-update install kylin-update-service mirrors-update/ 
```


