# 应用解决方案镜像iso

## 解压镜像
包含拷贝镜像文件及启动镜像仓库

```shell
bash expand-mirror [path]
```

需要传入一个存储镜像文件的目录，要求目录大小至少为 6G 。


## 仅启动镜像仓库
如需要重新部署镜像仓库，可使用以下命令
```shell
bash expand-mirror [path] --only-start
```
