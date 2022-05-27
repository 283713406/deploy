# 更新镜像列表

镜像分为主线版本与项目定制版本。

## 测试、补丁

本仓库中不包含生产环境数据，需要测试生产环境，请执行命令：
```shell
./mklist.sh offline
```
此命令将生成生产环境镜像列表


## 主线版本镜像更新

主线版本镜像更新，请更新到以下文件：

    - `amd64`(`x86_64`): `images_dev-amd64.yaml`
    - `arm64`(`aarch64`): `images_dev-amd64.yaml`

更新对应的镜像tag即可

## 项目定制镜像版本

若需要增加项目定制版本，请增加一个定制版本的镜像列表文件，文件以格式 `images_dev-[project].yaml` 命名，如

```shell
$ cat images_dev-icbc.yaml
global:
  images:
    httpd:                        "registry.kylincloud.org:4001/solution/tianyu/arm64/httpd:2.4.53-custom"
    monitorSync:                  "registry.kylincloud.org:4001/solution/tianyu/arm64/monitor-sync:3.6.1.34"
    monitorVnc:                   "registry.kylincloud.org:4001/solution/tianyu/arm64/monitor-vnc:1.0.2"
    policyService:                "registry.kylincloud.org:4001/solution/tianyu/arm64/policy-service:3.6.2.4"
    registerService:              "registry.kylincloud.org:4001/solution/tianyu/arm64/register-service:3.6.2.8"
    serverService:                "registry.kylincloud.org:4001/solution/tianyu/arm64/server-service:3.6.2.8"
    ssmwebsite:                   "registry.kylincloud.org:4001/solution/tianyu/arm64/ssmwebsite:3.6.1.7-ICBC"
```

**定制版本镜像中只存储相对主线版本不一致的镜像。**

完成本文件后，需要编辑 `project.arch` 文件:

```shell
$ cat project.arch
# 存储项目对应的架构
icbc    arm64
```
