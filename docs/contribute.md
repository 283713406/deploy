# 该文档为开发者服务
如何更新 git submodule
## 对于已经存在于gitlab master分支上的 git submodule
```bash
# 进入更新目录，拉取最新代码
$ cd dbinit
$ git pull
# 返回根目录，查看git 状态
$ cd -
$ git status
$ git add / git commit /git push
```

## 对于还没push的仓库，如何更新 git submodule
当已经通过 `git submodule add` 命令添加为 submodule的仓库，其仓库更新了内容，需要在本仓库同步内容。
```bash
# 例如 mysql 的 master 分支更新了内容

# 删除 mysql 内容
$ vi .gitmodules
$ vi .git/config
# 删除 .git/modules/ 下 mysql 目录
$ rm -rf .git/modules/subcharts/mysql/

# 删除 mysql 目录
$ rm -rf subcharts/mysql/
$ git add subcharts/
# 重新添加 mysql 
$ git submodule add {mysql gitlab url} subcharts/mysql
```