# ubuntu git server 安装

## 1 安装git-core

```
sudo apt-get install git-core python-setuptools openssh-server openssh-client
```

## 2 创建git用户并初始化密码

```
sudo useradd -m git
sudo passwd git
```

## 3 建立git用户使用目录

```
sudo mkdir /home/gitrepository

sudo chown git:git /home/gitrepository

sudo ln -s /home/gitrepository /home/git/repositories
```

## 4 安装Gitosis软件

```
git clone https://github.com/res0nat0r/gitosis.git

cd gitosis
sudo python setup.py install
```

## 5 生成管理员ssh公钥并拷贝到服务器

```
ssh-keygen -t rsa

scp .ssh/id_rsa.pub git@IP:/tmp

```

## 6 初始化gitosis 让管理员公钥生效

```
sudo -H -u git gitosis-init < /tmp/id_rsa.pub  # 上传上来的公钥目录
```


## 7 使用管理员克隆gitosis配置库
```
git clone git@localhost:gitosis-admin.git
```

> 如果报错可以使用绝对路径
```
git clone git@localhost:/home/gitrepository/gitosis-admin.git
```


## demo

```
cd /home/gitrepository && mkdir test.git
git --bare init #创建空项目　
git clone git@120.77.38.187:/home/gitrepository/test.git
git push origin master

```


