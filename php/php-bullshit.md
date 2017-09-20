# 流浪剑客这下牛B了之php-bullshit

## 浏览器请求

> 请求同步与异步(AJAX), 区别在于，同步传输面向比特的传输，单位是帧。异步则是面向字符的传输，单位是字符。

    web服务收到请求，通过解析HTTP头信息，得到相应的请求uri，然后再由web服务器的守护进程fork一个子进程
在子进程里面执行相应的程序。执行完后将结果标准输出返回到子进程。子进程将结果再返回给浏览器


## web服务器

    参考《Linux高性能服务器编程》

* 万变不离其宗之——[Linux I/O复用](https://github.com/daniel1988/notebook/blob/master/linux/linux-io-%E5%A4%8D%E7%94%A8.md)

* 负载均衡(略)

## php执行流程[详情](http://www.php-internals.com/book/?p=chapt02/02-01-php-life-cycle-and-zend-engine)

> PHP执行主要有两个阶段：处理请求之前的开始阶段和请求之后的结束阶段。

* 开始阶段有两处过程

    ** 第一个过程是模块初始化(MINIT),该阶段在web服务器启动后的整个生命周期。该过程只执行一次

    ** 第二个过程是请求之前都会进行模块激活(RINIT)

*　结束阶段

    ** 一个在请求结束后停用模块(RSHUTDOWN，对应RINIT)

    ** 一个在SAPI生命周期结束（Web服务器退出或者命令行脚本执行完毕退出）时关闭模块(MSHUTDOWN，对应MINIT)

## php变量、函数、类

    整个php的数据结构无非就是Hash Table、双向链表

## php内存管理

    引用计数、写时复制

## php进程管理

    fast-cgi，php-fpm

## Mysql

* SQL、索引优化(略)

* Mysql 存储架构[参考](https://github.com/daniel1988/notebook/blob/master/mysql/mysql-1.md)

    连接池、解析器、优化器、查询缓存、存储引擎组成

* InnoDB存储结构[参考](https://github.com/daniel1988/notebook/blob/master/mysql/mysql-2.md)

* Mysql 分表[参考](https://github.com/daniel1988/notebook/blob/master/mysql/mysql-3.md)

## NoSQL

    Memcache、Redis、MongoDB、TT等

* Memcache失效重连

* Redis 持久化： RDB与AOF

* MongoDB、TT(略)

## Linux常用命令[参考](https://github.com/daniel1988/notebook/tree/master/linux)

## 前端

总结的不多[仅供参考](https://github.com/daniel1988/notebook/tree/master/html5)





