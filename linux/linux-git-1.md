# Git

## 安装(ubuntu)
```
$ sudo apt-get install git
```

## 基本设置

`git config` 命令可以对 Git 版本库进行配置，需要在 git 安装完成后执行以下命令：

    git config --global core.autocrlf input # 在提交时把CRLF转换成LF，检出时不转换\]
    git config --global core.filemode false # 忽略文件权限修改引起的冲突
    git config --global core.safecrlf true # 拒绝提交包含混合换行符的文件
    git config --global push.default simple # 只推送本地当前分支，且与上游分支名字一致
    git config --global user.email  453465565@qq.com # 指定推送分支使用的 email
    git config --global user.name daniel # 指定推送分支使用的 name

## 基本操作

```
$ mkdir pro_1
$ cd pro_1
$ git init　　　　#创建版本库

$ git add .
$ git commit -m ' + readme.txt'
$ git push      # 推送到远程

$ git pull

$ git checkout -b dev_test    # 新建分支

$ git checkout master         # 切换分支

```

## Git clone

`git clone https://github.com/daniel1988/notebook.git`

## 标签管理

```
$ git tag v0.9  #创建标签

$ git tag       #查看所有标签
v0.9
v1.0

$ git tag -d v0.9   #删除标签
Deleted tag 'v0.9' (was 2cc18ed)

$ git tag
v1.0

$ git push origin v1.0      # 推送到远程
Total 0 (delta 0), reused 0 (delta 0)
To git@github.com:danielluo/notebook.git
 * [new tag]         v1.0 -> v1.0

$ git push origin --tags    #推送所有tag到远程

```


## Git 工具

* Git自动补全

```
cd ~
curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

```
然后，添加下面几行到~/.bash_profile文件中:
```
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi
```

* Git忽略文件

.gitignore
```
.cake_task_cache
.idea
.svn
.tags
.tags_sorted_by_file
```

* git blame [file_name]

* git log
```
 --oneline 压缩模式，在每个提交的旁边显示经过精简的提交哗然码和提交信息，以一行显示
 --graph 图开模式，
 --all 显示所有分支的历史记录
```

* 压缩多个commit

`git rebase -i HEAD~[number_of_commits]`

    如压缩最后两个commit:
```
$ git rebase -i HEAD~2
```

* git stash

* git cherry-pick
    cherry-pick就是从不同的分支中捡出一个单独的commit，并把它和你当前的分支合并。
`git cherry-pick [commit_hash]`


* 清空本地分支
```
git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print\n$1}' | xargs git branch -d
```
