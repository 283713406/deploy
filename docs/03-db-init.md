# DBInit
用于初始化MySQL和mongoDB的数据，values.yaml内的数据除非开发调试，或者开发人员指导否则请不要修改。

创建namespaces
```bash
$ kubectl create ns dbinit
```

如果架构为x86
```bash
$ sed -i s/arm64/amd64/g values.yaml 
```

启动Job:
```bash
# 注意在dbinit上级目录执行
$ helm -n dbinit install dbinit ./
```

查看结果:
```bash
$ kubectl -n dbinit get all

NAME                  READY   STATUS      RESTARTS   AGE
pod/mysql-job-vgss5   0/1     Completed   0          17m
pod/postgresql-job--1-twj8s   0/1     Completed    0          17m

NAME                    COMPLETIONS   DURATION   AGE
job.batch/mongodb-job   1/1           17m        17m
job.batch/mysql-job     1/1           2m57s      17m
job.batch/postgresql-job 1/1           2m57s      17m
```
查询结果符合下述即为成功：
* pod 状态为 Completed
* job COMPLETIONS 为1/1


## 简单
内部包含大量数据库的默认配置，除非开发人员指导否则无需修改。

```bash
$ vim dbinit/values.yaml
```
```yaml
# 修改mysql和mongo相关配置
mysql:
  kcm:
    username: "root"
    password: "Kcm.2021"
    # 主要修改uri，应填写 mysql 的 service.namespace
    uri: "ha-mysql.ha"
    port: "3306"
    database: "kcm"
  icbc:
    username: "root"
    password: "Kcm.2021"
    uri: "ha-mysql.ha"
    port: "3306"
    database: "kcm"
  init:
    kcm:
      enabled: true
    softshop:
      enabled: true
    mirrors_update:
      enabled: true

mongodb:
  # 主要修改uri，应填写 mongodb 的 service.namespace
  uri: "mongodb.ha"
  database: "test"
  port: "27017"
  username: "test"
  password: "Kim.1997"

postgres:
  # 主要需要修改uri，应填写postgres的 service.namespace
  uri: "acid-db.ha"
  port: "5432"
  username: "postgres"
  password: "zalando"  
# 修改mysql和mongo job镜像信息

job:
  image:
    mysql:
      # 注意根据机器实际信息修改 arm64 or amd64
      repository: "registry.kylincloud.org/solution/dbinit/arm64/mysql-job"
      tag: "0228"
      pullPolicy: "IfNotPresent"
    mongo:
      repository: "registry.kylincloud.org/solution/ha/mongodb/arm64/mongo"
      tag: "4.4.2"
      pullPolicy: "IfNotPresent"
    postgres:
      repository: "registry.kylincloud.org:4001/solution/dbinit/arm64/postgresql-job"
      tag: "0301"
      pullPolicy: "IfNotPresent"
```

