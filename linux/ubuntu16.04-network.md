# ubuntu 16.04 静态IP 网络问题

 `/etc/network/interfaces` 以下配置时, 有时会导致网络延迟很大


```
auto enp3s0
iface enp3s0 inet static
address 192.168.1.12
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameserver 202.96.134.133
dns-nameserver 113.106.88.16
```

## 解决方案

* `/etc/network/interfaces` 修改如下

```
auto enp3s0
iface enp3s0 inet static
address 192.168.1.12
netmask 255.255.255.0
gateway 192.168.1.1
```

* `/etc/NetworkManager/NetworkManager.conf`

```
[main]
plugins=ifupdown,keyfile,ofono
dns=dnsmasq

[ifupdown]
managed=true    # false 改为true
```

* 指定DNS `/etc/resolvconf/resolv.conf.d/base`

```
nameserver 202.96.134.133
nameserver 113.106.88.16
```


* `service networking restart`