# binlog , redo log , undo log

## undo log

为实现事务的原子性,在innodb中用undo log 来实现多版本的控制(mvcc)

- 原理

undo log原理很简单,为了满足事务的原子性,在操作任何数据之前,首先针数据备份到一个地方(这个存储数据备份的称为undolog)
然后进行数据的修改,如果出现了错误或者用户执行了roolback语句,系统可以利用undo log 中的备份将数据恢复到事务开始之前
的状态



## redo log

-原理

和undo 相反,redo log记录的是新数据的备份.在事务提交前,只将redo log 持久化即可,不需要将数据持久化.当系统崩溃时,虽然
数据没有持久化,但是redo log 已经持久化.系统可以根据redo log 的内容,将所有数据恢复到最新的状态.


## binlog

mysql 的binlog 日志作用是用来记录mysql 的内部的CRUD等对mysql数据库中有更新的内容的记录．对查询select 与show 等不会被
binlog日志记录．主要用于数据库的主从复制以及增量恢复．mysql 的binlog日志必须打开log-bin功能才能生成binlog日志

### mysql bin log 解析工具

mysqlbinlog功能是将mysql的binlog日志转化为mysql语句，默认情况下binlog日志是二进制文件，无法直接查看

### binlog的三种工作模式

* 1. Row level

日志会记录每一行数据被修改的情况，然后在slave端对相同的数据进行修改
优点：能清楚的记录每一行数据修改的细节
缺点：数据量太大

* 2. Statement level (默认)

每一条被修改数据的sql都会记录到Master的bin-log中，slave在提制的时候sql进程会解析成和原来master端执行过的相同sql再次执行
优点：了row level下的缺点，不需要记录每一行数据变化，减少了bin-log日志量，节约磁盘io
缺点：容易出现主从提制不一致

* 3. Mixed(混合模式)

结合了Row level和Statement level的优点

### mysql 企业binlog模式的选择

* 不用存储过程＼触发器＼函数的公司，默认statement level

* 用到Mysql特殊功能(存储过程, 触发器, 函数)则选择Mixed模式

* 用到特殊功能(存储过程, 触发器, 函数)，又希望数据最大化一直则是row模式

### 使用

```
mysql>show global variables like "binlog%";
+-----------------------------------------+-----------+
| Variable_name                           | Value     |
+-----------------------------------------+-----------+
| binlog_cache_size                       | 1048576   |
| binlog_direct_non_transactional_updates | OFF       |
| binlog_format                           | STATEMENT |       #系统默认为STATEMENT模式
| binlog_stmt_cache_size                  | 32768     |
+-----------------------------------------+-----------+
```

* 设置binlog 模式

```
mysql>set global binlog_format='ROW';
```

* 配置文件中设置binlog 模式

```
#vim my.cnf
[mysqld]
binlog_format='ROW'          #放在mysqld模块下面
user    = mysql
port    = 3306
socket  = /data/3306/mysql.sock
```





