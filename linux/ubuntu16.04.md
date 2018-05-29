
## gitlab 安装

* 安装依赖包
```
sudo apt-get install curl openssh-server ca-certificates postfix
```

* [添加清华大学镜像](https://mirror.tuna.tsinghua.edu.cn/help/gitlab-ce/)

首先信任 GitLab 的 GPG 公钥

```
curl https://packages.gitlab.com/gpg.key 2> /dev/null | sudo apt-key add - &>/dev/null

```

利用root用户1（不是sudo，而是root），vi打开文件/etc/apt/sources.list.d/gitlab-ce.list，加入下面一行

```
deb https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu xenial main
```

* 安装 gitlab-ce

```
sudo apt-get update
sudo apt-get install gitlab-ce


sudo gitlab-ctl reconfigure
```

> 了使 GitLab 社区版的 Web 界面可以通过网络进行访问，我们需要允许 80 端口通过防火墙，这个端口是 GitLab 社区版的默认端口。为此需要运行下面的命令

```
sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
```

检查GitLab是否安装好并且已经正确运行，输入下面的命令

```
sudo gitlab-ctl status
```


## Ubuntu 启动相关

* 设置命令行启动

```
sudo systemctl set-default multi-user.target

```

* 启动图型桌面
```
sudo systemctl start lightdm
```

* 设置默认图型界面启动

```
sudo systemctl set-default graphical.target
```