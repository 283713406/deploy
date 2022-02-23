# deploy
整合部署应用软件及高可用软件。

## 如何使用
```bash
# 克隆项目
$ git clone git@gitlab.kylincloud.org:solution/deploy.git

# 进入项目更新git submodule
$ cd deploy/helm-chart
$ git submodule update --init --recursive

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


## 如何更新 git submodule
当 git submodule更新了内容，需要在本仓库同步内容。
```bash
# 例如 mysql 的 master 分支更新了内容

# 删除 mysql 内容
$ vi .gitmodules
$ vi .git/config
# 删除 .git/modules/ 下 mysql 目录
$ rm -rf .git/modules/subcharts/mysql/

# 删除 mysql 目录
$ rm -rf subcharts/mysql/
$ git add subcharts/mysql/
# 重新添加 mysql 
$ git submodule add {mysql gitlab url} subcharts/mysql
```
