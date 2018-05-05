
# SCP

scp 命令用于linux之间复制文件和目录 。scp是secure copy的缩写，scp 是linux系统下基于ssh登录进行安全远程文件拷贝命令

> scp [可选参数] source_file target_file

## 本地文件传到服务器

```
scp *.log danielluo@127.0.0.1:/data
```


## 下载

```
scp danielluo@127.0.0.1:/data/xxx.zip /tmp
```

## 复制目录

```
scp -r /data/temp/xxx/ danielluo@127.0.0.1:/data/temp


scp -r /data/temp/xxx 127.0.0.1:/data/temp
``

## 两主机复制不输入密码

```
scp -r /home/daniel/.ssh/id_rsa.pub danielluo@120.77.38.187:/home/danielluo/.ssh/authorized_keys
```

> RSA 生成查看[linux-openssl.md](linux-openssl.md)