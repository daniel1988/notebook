# Ubuntu Memcache 系统启动

## 参数

* -d
>>以守护进程启动

* -m
>> 内存大小

* -u memcache
>>用户

* -l
>> 127.0.0.1 # IP



## 安装
`sudo apt-get install memcache`

    * 配制文件：
>> /etc/memcached.conf  # 默认端口为11211

    * 启多个端口:
```
$ sudo cp /etc/memcached.conf /etc/memcached_server1.conf
```

## 启动
```
$ sudo /etc/init.d/memcached start server1
Starting memcached: memcached_server1.
$ sudo /etc/init.d/memcached stop
Stopping memcached: memcached_server1.
# 或者
$ sudo service memcached start
Starting memcached: memcached_server1.

```


