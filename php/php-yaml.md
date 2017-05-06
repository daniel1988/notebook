## php-yaml拓展安装



```
sudo yum install libyaml libyaml-devel

```

## 查看pecl最新的安装

[https://pecl.php.net/package/yaml](https://pecl.php.net/package/yaml)

```
sudo wget https://pecl.php.net/get/yaml-1.3.0.tgz

tar -zxvf yaml-1.3.0.tgz

cd yaml-1.3.0

sudo phpize

sudo ./configure

sudo make

sudo make install

sudo echo "extension=yaml.so">/etc/php.d/yaml.ini

sudo service php-fpm restart

```

