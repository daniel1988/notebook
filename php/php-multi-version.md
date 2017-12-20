# php-multi-version

## ubuntu apt-get 安装php5.6

* 添加软件源
```
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

sudo apt-get install php5.6

sudo apt-get install php5

sudo apt-get install php7
```


## /usr/local/bin 与/usr/bin
```
echo $PATH

/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

```
> 如果安装了多个版本php，如apt-get 安装了php5 会放在/usr/bin/php ，如果再源码安装默认时/usr/local/bin/php<br>
如果命令行下执行`php -v`执行的是/usr/local/bin/php。如果想让默认的执行/usr/bin/php，可以建立软链接<br>

```
sudo mv /usr/local/bin/php /usr/local/bin/php5.5
sudo ln -s /usr/bin/php /usr/local/bin/php
```
> 相应的phpize  php-config等也需要修改


## 源码安装

[下载](http://php.net/downloads.php)

* 创建用户

```
useradd www-data -s /sbin/nologin -M
```

* 配制


```
./configure --prefix=/usr/local/php5.6 --with-config-file-scan-dir=/usr/local/php5.6/etc --with-config-file-path=/usr/local/php5.6/etc --enable-opcache --enable-fpm --enable-pdo --enable-sockets --enable-exif --enable-soap --enable-ftp --enable-wddx --enable-pcntl --enable-soap --enable-bcmath --enable-mbstring --enable-dba --enable-gd-native-ttf --enable-gd-jis-conv --enable-zip --enable-calendar --enable-shmop --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-mysqli --with-pdo-mysql --with-pdo-sqlite --with-iconv --with-gettext --with-xmlrpc --with-openssl --with-curl --with-pcre-regex --with-gd --with-pear --with-fpm-user=www-data --with-fpm-group=www-data

```


```
./configure --prefix=/usr/local/php7 --with-config-file-path=/usr/local/php7/etc --enable-opcache --enable-fpm --enable-pdo --enable-sockets --enable-exif --enable-soap --enable-ftp --enable-wddx --enable-pcntl --enable-soap --enable-bcmath --enable-mbstring --enable-dba --enable-gd-native-ttf --enable-gd-jis-conv --enable-zip --enable-calendar --enable-shmop --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-mysqli --with-pdo-mysql --with-pdo-sqlite --with-iconv --with-gettext --with-xmlrpc --with-openssl --with-curl --with-pcre-regex --with-gd --with-pear --with-fpm-user=www-data --with-fpm-group=www-data

sudo make && make install


```

```
sudo ln -s /data/php7/bin/php /usr/local/bin/php7
```



