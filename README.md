# deploy
整合部署应用软件及高可用软件。

## 如何使用
### 部署nfs storage class
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
需要现部署nfs，再部署其他组件。

### 部署应用及组件
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
### 常用helm命令解释
```bash
$ helm install -n ha hacomponent ./
# helm 安装命令，-n 为命名空间，hacomponent为helm chart名字，./代表chart所在路径
# 注：同一个命名空间下chart 名字不可重复
$ helm -n ha delete hacomponent
# 删除ha 命名空间下的hacomponentchart
```
