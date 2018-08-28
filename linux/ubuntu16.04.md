
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


## Ubuntu 与windows双系统硬盘挂载bug

`/etc/fstab`挂载了三个盘到相应目录， 当在windows运行久时会留下一些metadata数据，导致ubuntu启动有问题。主要原因就是挂载以下
的目录不兼容

```
UUID=BA12499812495B11 /data ntfs defaults 0 1
UUID=849A41F69A41E570 /e ntfs defaults 0 1
UUID=FEBC45DABC458E59 /f ntfs defaults 0 1


/dev/sda2       305G   31G  275G   10% /e
/dev/sda4       306G   25G  282G    8% /data
/dev/sda3       305G  9.4G  296G    4% /f

```
* Step 1

注释以上相应的挂载，重新启动. 如果知道挂载的分区即可直接运行`ntfsfix /dev/sdb4`修复

* Step 2

```
fdisk -l
/dev/sdb1       2048    204799    202752   99M EFI System
/dev/sdb2     204800    466943    262144  128M Microsoft reserved
/dev/sdb3     466944   2564095   2097152    1G Microsoft basic data
/dev/sdb4    2564096 167095090 164530995 78.5G Microsoft basic data
/dev/sdb5  167096320 168798207   1701888  831M Windows recovery environment
/dev/sdb6  168800256 233502719  64702464 30.9G Linux filesystem
/dev/sdb7  233502720 250068991  16566272  7.9G Linux swap

```

`blkid` 查看相应的uuid对应的挂载分区

> `ntfsfix /dev/sdb4` 修复相应分区，再重启系统



## ubuntu16.04 启动时黑屏

* 使用 ctrl + alt + F1 进入命令行模式

* 修改`/etc/default/grub`文件

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
```
修改为
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"
```
