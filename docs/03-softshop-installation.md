## 软件商店client与manage的部署
1.克隆项目
```bash
git clone https://gitlab.kylincloud.org/solution/softshop.git
```
2.修改client与manage数据库等基本配置参数
```bash
cd softshop/client/ or cd softshop/manage/
vim values.yaml
```
3.创建k8s namespaces
```bash
kubectl create ns apps
```
4.开始部署
```bash
cd softshop/

#部署client
helm install client -n apps client/

#部署manage
helm install manage -n apps manage/
```
5.查看是否部署成功(全部Running则成功)
```bash
helm -n apps list
kubectl -n apps get pods -o wide
```
6.删除
```bash
helm -n apps delete client
helm -n apps delete manage
```
