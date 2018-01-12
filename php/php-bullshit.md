# php-interview-bullshit

## 前提

怎样用一句话扯完php interview中的所有问题，从一个网页的请求开始吧！


## 请求

客户端(浏览器)请求分为两种，一种是同步请求，一种是异步(AJAX)请求。 区别在于，同步传输面向比特的传输，单位是帧。
异步则是面向字符的传输，单位是字符

* http请求

    http协议是基于tcp/ip协议之上，因此，tcp三次握手（请求连接服务器），四次挥手（关闭服务器释放资源）

* RPC请求

    rpc主要目标让构建分布式计算（应用）更容易，在提供强大的远程调用能力时不损失本地调用的主义简洁性。也有同步与异步之分。
    实现的方式采用序列化编码，常见的格式有：
    1. xml: webservice SOAP
    2. json: json-rpc
    3. binary: thrift, protobuf等

> 序列化编码主关心的点有：
1. 序列化和反序列化的效率，越快越好
2. 序列化后的字节长度，越小越好
3. 序列化和反序列化的兼容性，接口若增加字段是否兼容。


* http状态码与header参数

    http状态码：1xx——服务器信息　　　2xx——成功相关　　3xx——重定向  4xx —— 客户端错误信息　5xx——服务器端错误



# 服务器收到请求

客户端发起请求后，web服务器(nginx, apache等)收到请求并转发给php相应的进程管理(php-fpm , fastcgi等)

## web

## HTTP 请求

* tcp三次握手

* 请求流程

> 请求同步与异步(AJAX), 区别在于，同步传输面向比特的传输，单位是帧。异步则是面向字符的传输，单位是字符。

web服务收到请求，通过解析HTTP头信息，得到相应的请求uri，然后再由web服务器的守护进程fork一个子进程,
在子进程里面执行相应的程序。执行完后将结果标准输出返回到子进程。子进程将结果再返回给浏览器


## web服务器

* 万变不离其宗之——[Linux I/O复用](https://github.com/daniel1988/notebook/blob/master/linux/linux-io-%E5%A4%8D%E7%94%A8.md)

> 无非就是nginx与apache区别————epoll与select


* 负载均衡

几种实现方式：http重定向、反向代理负载均衡、IP负载均衡、DNS负载均衡等


## php执行流程[详情](http://www.php-internals.com/book/?p=chapt02/02-01-php-life-cycle-and-zend-engine)

> PHP执行主要有两个阶段：处理请求之前的开始阶段和请求之后的结束阶段。

* 开始阶段有两处过程

    ** 第一个过程是模块初始化(MINIT),该阶段在web服务器启动后的整个生命周期。该过程只执行一次

    ** 第二个过程是请求之前都会进行模块激活(RINIT)

* 结束阶段

    ** 一个在请求结束后停用模块(RSHUTDOWN，对应RINIT)

    ** 一个在SAPI生命周期结束（Web服务器退出或者命令行脚本执行完毕退出）时关闭模块(MSHUTDOWN，对应MINIT)

## php变量、函数、类

整个php的数据结构无非就是Hash Table、双向链表

## php内存管理

引用计数、写时复制

## php进程管理

fast-cgi，php-fpm

* php并行方式与实现

1、curl_multi请求，直接由php-fpm或者fast-cgi来管理

2、调用系统函数执行php文件
```
php -f xxoo.php &
```

3、使用拓展如pcntl、swoole等


## Mysql

* SQL、索引优化(略)

* Mysql 存储架构[参考](https://github.com/daniel1988/notebook/blob/master/mysql/mysql-1.md)

连接池、解析器、优化器、查询缓存、存储引擎组成

* InnoDB存储结构[参考](https://github.com/daniel1988/notebook/blob/master/mysql/mysql-2.md)

* Mysql 分表[参考](https://github.com/daniel1988/notebook/blob/master/mysql/mysql-3.md)

## NoSQL

Memcache、Redis、MongoDB、TT等

* Memcache失效重连

* Redis 持久化

RDB与AOF

* MongoDB、TT(略)

## Linux常用命令

[参考](https://github.com/daniel1988/notebook/tree/master/linux)

[Shell demo](https://github.com/daniel1988/notebook/tree/master/shell-test)

## 前端

总结的不多[仅供参考](https://github.com/daniel1988/notebook/tree/master/html5)


## 其它语言

技多不压身，艺多不养人。





