# DBInit
用于初始化MySQL和mongoDB的数据，values.yaml内的数据除非开发调试，或者开发人员指导否则请不要修改。

启动Job:
```
$ helm [-n namespace] install dbinit ./
```

查看结果:
```bash
$ kubectl [-n namespace] get all

NAME                  READY   STATUS      RESTARTS   AGE
pod/mysql-job-vgss5   0/1     Completed   0          17m

NAME                    COMPLETIONS   DURATION   AGE
job.batch/mongodb-job   1/1           17m        17m
job.batch/mysql-job     1/1           2m57s      17m
```
查询结果符合下述即为成功：
* pod 状态为 Completed
* job COMPLETIONS 为1/1


## 简单
内部包含大量数据库的默认配置，除非开发人员指导否则无需修改。

```bash
$ vim values.yaml
```
```yaml
# 修改mysql和mongo相关配置
mysql:
  kcm:
    username: "root"
    password: "Kcm.2021"
    # 主要修改uri
    uri: "ha-mysql.ha"
    port: "3306"
    database: "kcm"
  icbc:
    username: "root"
    password: "Kcm.2021"
    uri: "ha-mysql.ha"
    port: "3306"
    database: "kcm"

mongodb:
  # 主要修改uri
  uri: "mongodb.ha"
  database: "test"
  port: "27017"
  username: "test"
  password: "Kim.1997"
# 修改mysql和mongo job镜像信息

job:
  image:
    mysql:
      # 注意根据机器实际信息修改 arm64 or amd64
      repository: "registry.kylincloud.org/solution/dbinit/arm64/mysql-job"
      tag: "0225"
      pullPolicy: "IfNotPresent"
    mongo:
      repository: "registry.kylincloud.org/solution/ha/mongodb/arm64/mongo"
      tag: "4.4.2"
      pullPolicy: "IfNotPresent"
```

