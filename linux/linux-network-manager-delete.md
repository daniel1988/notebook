
安装geth时，apt-get autoremove 把network-manager删除了＃＠￥＃＠￥＠＃
发现内网IP与路由都被干掉了。

## 配制IP与路由

```
 #!/usr/bin
sudo ifconfig eth0 10.1.16.50 netmask 255.255.255.0


sudo route add default gateway 10.1.16.1

```