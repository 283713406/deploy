# deploy
整合部署应用软件及高可用软件，部署的前提条件是k8s集群已经就绪。服务的部署顺序是：KIM部署->NFS部署->部署应用及组件

### 1. KIM部署
请参考[KIM部署](docs/01-kim-installation.md)

### 2. NFS部署
请参考[NFS 部署](docs/02-nfs-installation.md)

#### 2.1 部署nfs storage class
```bash
# 必要: 修改nfs 服务地址
$ make chost Host="192.168.1.1"

# 可选: 修改nfs 服务挂载目录，默认为: /k8s/nfs-storage/common
$ make cpath Path="/foo/bar"

# 可选: 修改为amd镜像，默认为arm镜像
$ make amd
# 如果上述3个步骤误操作，执行下面这句命令重置nfs配置，再重新执行上述3个步骤
$ git checkout nfs.yaml

# 必要: 部署nfs
$ make apply
```

### 3. 部署应用及组件
```bash
# 克隆项目
$ git clone git@gitlab.kylincloud.org:solution/deploy.git

# 更新git submodule
$ git submodule update --init --recursive

#进入项目
$ cd deploy/helm-chart

# 更新helm subchart
$ helm dependency update

# 修改values.yaml调整需要部署的组件
$ vi values.yaml

# 建议将apisix与其他组件分开部署
$ vi values.yaml #将除了apisix.enabled以外开关设为false
# 新建命名空间，命名空间为 apisix-system
$ kubectl create ns apisix-system
$ helm install -n apisix-system apisix ./

$ vi values.yaml #将除了apisix.enabled设为false，其他组件开关设为true
$ kubectl create ns ha
$ helm install -n ha ha ./
```

#### 3.1 部署仓库源
```bash
$ git clone https://gitlab.kylincloud.org/solution/repo.git
#后续部署请 联系 朱信 支持
```

#### 3.2 部署软件商店
请参考[软件商店](docs/03-softshop-installation.md)

#### 3.3 部署源更新
```bash
$ git clone https://gitlab.kylincloud.org/solution/mirrors-update.git
$ helm -n kylin-update install kylin-update-service mirrors-update/ 
```

### 常用helm命令解释
```bash
$ helm install -n ha hacomponent ./
# helm 安装命令，-n 为命名空间，hacomponent为helm chart名字，./代表chart所在路径
# 注：同一个命名空间下chart 名字不可重复
$ helm -n ha delete hacomponent
# 删除ha 命名空间下的hacomponentchart
```
