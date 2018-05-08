
## GIT 权限配置

配置全局的name 和email


```
git config --global user.name "danielluo"

git config --global user.email "danielluo@acingame.com"
```



## Ubuntu 生成 RSA

* 安装OpenSSL

```
sudo apt-get install openssl
```

* RSA GEN

```
ssh-keygen -t rsa -C "your_email@example.com"
```



## Windows 生成 RSA

下载[gitbash](https://git-scm.com/downloads)


```
cd ~/.ssh

ssh-keygen -t rsa -C "danielluo@acingame.com"

```

> 没有相应目录可自己创建`C:\Users\Administrator\.ssh`

查看`C:\Users\Administrator\.ssh\id_rsa.pub`

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFTll1qfVNSmFxcP5GRAbULCnVfZHGj2eUxqqfMSdJprD1CJMLjvW8SutYmt283F3pBUiPYaNuaHN50FFC2FwbuvR5fDMyI/FKpV+UXD4aGBmx/8j6/IJM5tdzmoUG25zAa/HuyfYFzK6mgwvf+bvTCkOAwkQx15s64HNynflYQhxN8HOjugr0d5wr//pLkF2x0wLtgmCwl0X+wTt72iW/XI3RSHvZmVldrT2GBiKZCJh3DMdAX5OeuQ1wUX0LYnspgea8JyeI9s6jEfzzq6EnoS8aIGm+u9SBKjC6jy5Ip443eiiCfWbZuL8qwu/UdedaNzCOf4+6lMWFk0lYDaQ1 danielluo@acingame.com
```

复制以上内容加入[gitlab](http://192.168.1.236/profile/keys/new)


> 如果还是权限有问题,打开`/c/Users/Administrator/.ssh/known_hosts`清空里面的内容