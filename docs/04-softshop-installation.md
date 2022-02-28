## 软件商店client与manage的部署
1.克隆项目
```bash
git clone https://gitlab.kylincloud.org/solution/softshop.git
cd softshop
git checkout hebing
```
2.修改client与manage数据库等基本配置参数
```bash
# 切换到softshop上级目录
cd ../
#若若部署的环境为x86环境，则执行下述操作，为arm64环境则无需操作
sed -i 's/arm64/amd64/g' softshop/values.yaml
sed -i 's/2.1.0-arm/2.1.0-x86/g' softshop/values.yaml
```
3.创建k8s namespaces
```bash
kubectl create ns apps
```
4.开始部署
```bash

#部署client与manage，切换到softshop上级目录
helm install kylin-softshop -n apps softshop/
```
5.查看是否部署成功(全部Running则成功)
```bash
helm -n apps list
kubectl -n apps get pods -o wide
```
6.删除
```bash
helm -n apps delete kylin-softshop
```
