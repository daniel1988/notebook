## Undo Log[原文链接](https://blog.csdn.net/lpx_cn/article/details/53737165)

undoe log 是Mysql innodb引擎的日志的一种，记录了老版本的数据．是innodb mvcc 重要组成部分，innodb的mvcc就是基于
undo log 实现的

当操作数据时，就会产生undo记录，undo记录默认记录在系统表空间(ibdata)中，从Mysql5.6开始，undo使用的表空间可以
分离为独立的undo　log文件

在innodb中，insert操作在事务提交前只对当前事务可见,undo log 在事务提交后即会被删除，因为新插入的数据没有历史版本
所以无需维护undo log .而对于update , delete 则需要维护多版本信息．

> innodb 中,update＼delete 操作产生的undo log 都属于同一类型:update_undo．update可视为insert新数据到原位置，delete
旧数据．undo log 暂时保留旧数据


## undo log 的作用

mvcc使innodb能够实现一致性非锁定读

在innodb中，要对一条数据进行处理，会先看这条数据的版本号是否大于本身事务版本(非RU隔离级别下当前事务发生之后的事务
对当前事务来说是不可见的)，如果大于，则从历史快照(undo log )中获取旧的版本数据，来保证数据一致性．

而由于历史版本数据存放在undo页中，对数据修改所加的锁对于undo页没有影响，所以不会影响到历史数据的读，从而达到非
一致性锁定读，提高并发性能


## undo log 结构

为了提高undo log 的并发操作，innodb将undo log 拆分为很多的浮动程序段(relocatable segment)来进行维护，每个rseg当中
又有多个undo log slot，每个事务一个slot

> 理论上来说innodb最多支持96 * 1024个普通事务