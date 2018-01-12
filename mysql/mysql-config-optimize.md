##　优化服务器设置


> 查看配置

```
which mysqld
/usr/sbin/mysqld

$ /usr/sbin/mysqld --verbose --help | grep -A 1 'Default options'

```

## 语法、作用域、动态性

配置项设置都使用小写，单词之间用下画线或横线隔开。

```
msyqld --auto-increment-offset=5
mysqld --auto_increment_offset=5
```

> 配置项可以有多个作用域。有些设置是服务器级的（全局）有些对每个连接是不同的（会话作用域），剩下的一些是对象级的。许多会话级别变量
跟全局变量相等，可以认为是默认值。如果改变会话级变量，只影响改动的当前连接，连接关闭时所有参数变更都失效。

