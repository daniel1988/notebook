# Ubuntu 下安装配置Rsync

>Rsync(remote synchronize) 是一个远程数据同步工具，可以使用Rsync算法，同步本地与远程主机的文件<br>
Rsync的好处是只同步两个文件不同的部分，相同的部分不在传递。类似于增量备份，这使的在服务器传递备份<br>
文件或者同步文件，比起scp工具省好多的时间

## 启动rsync
>Ubuntu 14.04默认已安装rsync, rsync服务默认不是启动的

* 需要修改启动配置文件

```
sudo vim /etc/default/rsync

RSYNC_ENABLE=true   #false改true
```

* 修改rsync配置文件
`sudo cp /usr/share/doc/rsync/examples/rsyncd.conf /etc   #已默认安装的软件，默认不启动的似乎都要这么做 `

```
# sample rsyncd.conf configuration file

# GLOBAL OPTIONS

#motd file=/etc/motd #登录欢迎信息
#log file=/var/log/rsyncd #日志文件
# for pid file, do not use /var/run/rsync.pid if
# you are going to run rsync out of the init.d script.
pid file=/var/run/rsyncd.pid

#指定rsync发送日志消息给syslog时的消息级别，常见的消息级别是：uth, authpriv, cron, daemon, ftp, kern, lpr, mail, news, security, sys-log, user, uucp, local0, local1, local2, local3,local4, local5, local6和local7。默认值是daemon。
#syslog facility=daemon

#自定义tcp选项，默认是关闭的
#socket options=

#以下是模块信息，我们可以创建多个模块
# MODULE OPTIONS

[ftp]

        comment = public archive #模块描述
        path = /var/www/pub #需要同步的路径
        use chroot = yes #默认是yes|true，如果为true，那么在rsync在传输文件以前首先chroot到path参数指定的目录下。这样做的原因是实现额外的安全防护，但是缺点是需要root权限，并且不能备份指向外部的符号连接指向的目录文件。
#       max connections=10 #最大连接数
        lock file = /var/lock/rsyncd #指定支持max connections参数的锁文件。
# the default for read only is yes...
        read only = yes #只读选项
        list = yes #客户请求时可用模块时是否列出该模块
        uid = nobody #设定该模块传输文件时守护进程应该具有的uid
        gid = nogroup #设定该模块传输文件时守护进程应具有的gid，此项与uid配合可以确定文件的访问权限
#       exclude = #用来指定多个由空格隔开的多个模式列表，并将其添加到exclude列表中。这等同于在客户端命令中使用--exclude来指定模式，不过配置文件中指定的exlude模式不会传递给客户端，而仅仅应用于服务器。一个模块只能指定一个exlude选项，但是可以在模式前面使用"-"和"+"来指定是exclude还是include    #这个我的理解是排除目录中不需同步的文件
#       exclude from = #可以指定一个包含exclude模式定义的文件名
#       include = #与exclude相似
#       include from = #可以指定一个包含include模式定义的文件名
#       auth users = #该选项指定由空格或逗号分隔的用户名列表，只有这些用户才允许连接该模块。这里的用户和系统用户没有任何关系。如果"auth users"被设置，那么客户端发出对该模块的连接请求以后会被rsync请求challenged进行验证身份这里使用的 challenge/response认证协议。用户的名和密码以明文方式存放在"secrets file"选项指定的文件中。默认情况下无需密码就可以连接模块(也就是匿名方式)
#       secrets file = /etc/rsyncd.secrets #该文件每行包含一个username:password对，以明文方式存储，只有在auth users被定义时，此选项才生效。同时我们需要将此文件权限设置为0600
        strict modes = yes #该选项指定是否监测密码文件的权限，如果该选项值为true那么密码文件只能被rsync服务器运行身份的用户访问，其他任何用户不可以访问该文件。默认值为true
#       hosts allow = #允许的主机
#       hosts deny = #拒绝访问的主机
        ignore errors = no #设定rsync服务器在运行delete操作时是否忽略I/O错误
        ignore nonreadable = yes #设定rysnc服务器忽略那些没有访问文件权限的用户
        transfer logging = no #使rsync服务器使用ftp格式的文件来记录下载和上载操作在自己单独的日志中
#       log format = %t: host %h (%a) %o %f (%l bytes). Total %b bytes. #设定日志格式
        timeout = 600 #超时设置(秒)
        refuse options = checksum dry-run #定义一些不允许客户对该模块使用的命令选项列表
        dont compress = *.gz *.tgz *.zip *.z *.rpm *.deb *.iso *.bz2 *.tbz #告诉rysnc那些文件在传输前不用压缩，默认已设定压缩包不再进行压缩
```

## 日志格式选项列表
```
%h: 远程主机名
%a: 远程IP地址
%l: 文件长度字符数
%p: 该次rsync会话的进程id
%o: 操作类型："send"或"recv"、”del.”
%f: 文件名
%P: 模块路径
%m: 模块名
%t: 当前时间
%u: 认证的用户名(匿名时是null)
%b: 实际传输的字节数
%c: 当发送文件时，该字段记录该文件的校验码
```

## 定义自己的配置
```
# MODULE OPTIONS

[local_rsync]

        comment = local rsync server
        path = /data/temp
        use chroot = yes
#       max connections=10
        lock file = /var/lock/rsyncd
# the default for read only is yes...
        read only = yes
        list = yes
        uid = nobody
        gid = nogroup
#       exclude =
#       exclude from =
#       include =
#       include from =
#       auth users =
#       secrets file = /etc/rsyncd.secrets
        strict modes = yes
#       hosts allow =
#       hosts deny =
        ignore errors = no
        ignore nonreadable = yes
        transfer logging = no
#       log format = %t: host %h (%a) %o %f (%l bytes). Total %b bytes.
        timeout = 600
        refuse options = checksum dry-run
        dont compress = *.gz *.tgz *.zip *.z *.rpm *.deb *.iso *.bz2 *.tbz
```