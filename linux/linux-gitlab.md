## 安装依赖

```
sudo apt-get install curl openssh-server ca-certificates postfix
```

## install gitlab

```
curl -sS http://packages.gitlab.cc/install/gitlab-ce/script.deb.sh | sudo bash

sudo apt-get install gitlab-ce
```

> 太慢的话，可以直接下载安装包

```
curl -LJO https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu/pool/xenial/main/g/gitlab-ce/gitlab-ce-XXX.deb
dpkg -i gitlab-ce-XXX.deb
```


## 配置gitlab `/etc/gitlab.rb`

```
external_url 'http://192.168.1.236'

gitlab_rails['gitlab_email_from'] = 'danielluo@acingame.com'

gitlab_rails['smtp_enable'] = true

gitlab_rails['smtp_address'] = "smtp.mxichina.com"
gitlab_rails['smtp_prot'] = 26
gitlab_rails['smtp_user_name'] = "danielluo@acingame.com"
gitlab_rails['smtp_password'] = "lz@xxxxxx"
gitlab_rails['smtp_domain'] = "acingame.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
```

## 启动相关命令

```
sudo gitlab-ctl reconfigure

sudo gitlab-ctl stop

sudo gitlab-ctl start

```



## 备份与迁移

* 创建备份

```
gitlab-rake gitlab:backup:create
```

> 备份目录在`/var/opt/gitlab/backups`

* 自动备份

```
sudo su
crontab -e

0 2 * * * /opt/gitlab/bin/gitlab-rake gitlab:backup:create

```

* 恢复

```
# 停止相关数据连接服务
gitlab-ctl stop unicorn
gitlab-ctl stop sidekiq

# 从1393513186编号备份中恢复
gitlab-rake gitlab:backup:restore BACKUP=1393513186

# 启动Gitlab
sudo gitlab-ctl start
```