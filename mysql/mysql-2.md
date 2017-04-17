# InnoDB 物理存储结构

* 从物理意义上来讲，InnoDB是由表空间（独立表空间、共享表空间）、日志文件组(redo文件组)、表结构定义文件组成。

## 独占表空间

* 若将innodb_file_per_table设置为on，则系统将为每个表单独生成一个table_name.idb的文件,在此文件中，
存储与该表相关的数据、索引、表的内部数据字典。表结构文件则以.frm结尾，这与存储引擎无关

## 共享表空间

* 若将innodb_file_per_table设置为off | 0

* 在InnoDB存储引擎中，默认表空间文件是ibdata1，初始化为10M，且可以拓展

```
mysql> show variables like 'innodb_data%';
+-----------------------+------------------------+
| Variable_name         | Value                  |
+-----------------------+------------------------+
| innodb_data_file_path | ibdata1:10M:autoextend |
| innodb_data_home_dir  |                        |
+-----------------------+------------------------+
```
可以修改为：
```
Innodb_data_file=ibdata1:128M;ibdata2:50M:autoextend
```
> 使用共享表空间存储方式时，Innodb的所有数据保存　在一个单独的间里面，而这个表空间可以由多个文件组成
一个表可以跨多个文件存在，所以其大小限制不再是文件大小的限制，而是其自身的限制。从InnoDB官方文档可以看到，
其表空间最大的限制为64TB，也就是说，InnoDB的单表限制基本上也在64TB左右了，当然这个大小是包括所有索引等数据

> 而使用单独空间存储方式时，每个表的数据以一个单独的文件来存放，这时表的大小是由系统文件的大小来限制

```
Operating System  File-size Limit
Win32 w/ FAT/FAT32  2GB/4GB
Win32 w/ NTFS          2TB (possibly larger)
Linux 2.4+          (using ext3 file system) 4TB
Solaris 9/10          16TB
MacOS X w/ HFS+         2TB
NetWare w/NSS file system  8TB
```

## 独立表空间优缺点

> 优点：
1、每个表都有自己独立的表空间
2、表的数据与索引都会存在自己的表空间中
3、可以实现意表在不同的数据库中移动
4、空间可以回收（除drop table操作外，表空间不能自己回收）

> 缺点：
1、单表增加过大
2、对于启用了innodb_file_per_table的参数选项之后，在每个表对应的.idb文件内只是存放了数据，索引和插入缓冲，而撤销信息，系统事务
信息，二次写缓冲等还是存放在了原来的共享空间内
3、数据段即B+树叶节点，索引段即为B+树的非索引节点
4、InnoDB存储引擎的管理是由引擎本身完成的，表空间是由分散的页和段组成的
5、区由64个连续的页组成，每个页大小为16K，即每个区大小为1M，创建新表时，先有32页大小的碎片存放数据，使用完成后才是区的申请

>页类型有：数据页、Undo页、系统页、事务数据页、插入缓冲页、以及插入数据缓冲空闲列表页

## 共享表空间优缺点

> 优点：
1、可以放表空间分成多个文件存放到各个磁盘上（表空间文件大小不受表大小的限制，如一个表可以分布在不同的文件上）
数据与文件好管理

> 缺点：
1、所有的数据和索引放在一个文件中，对表做大量删除操作后表空间中将会有大量的空隙。不适合统计分析、日志系统


# Mysql 进程结构（innodb）

* innodb存储引擎后台有７个进程：

** 4个IO thread

** 1个master thread

** 1个锁监控进程

** 1个错误监控进程

* 后台进程主要的作用负责刷新内在池中的数据，保证缓冲池中的内在缓存的是最近的数据，此外将已修改的数据刷新到磁盘文件中，
同时保证在数据库发生异常情况下,Innodb参恢复到正常运行状态

```
mysql> show variables like'innodb_%io%';
+---------------------------------+---------+
| Variable_name                   | Value   |
+---------------------------------+---------+
| innodb_additional_mem_pool_size | 8388608 |
| innodb_io_capacity              | 200     |
| innodb_read_io_threads          | 4       |
| innodb_replication_delay        | 0       |
| innodb_use_native_aio           | ON      |
| innodb_version                  | 5.5.46  |
| innodb_write_io_threads         | 4       |
+---------------------------------+---------+
```

# InnoDB内存结构

* innoDB内存管理是通过一种称为内存堆的方式进行管理的。在对一些数据结构本身分配内存时，需要从额外的内存池中申请

* InnoDB存储引擎内存是由：缓存池、重做日志缓冲池、额外内存池分别配置文件的参数innodb_buffer_pool_size和innodb_log_buffer_size的大小决定

```
mysql> show variables like '%innodb_%_pool_size';
+---------------------------------+-----------+
| Variable_name                   | Value     |
+---------------------------------+-----------+
| innodb_additional_mem_pool_size | 8388608   |
| innodb_buffer_pool_size         | 134217728 |
+---------------------------------+-----------+
```
> 缓冲池是占最大的块内存部分，用来存放各种数据的缓存。因为InnoDB的存储引擎的工作方式总是将数据库文件按页（每页16k）读到缓冲池
然后按最近最少使用（LRU）算法来保留在缓冲中的缓存数据。如果数据库需要修改，总是先修改缓存池的页，然后再按照一定的频率将缓冲池
脏页刷新到文件中。可以通过show engine innodb status 来查看innodb_buffer_pool 的具体情况

* 缓存池：
    数据页类型有：索引页、数据页、undo页、插入缓冲（insert buffer）、自适应哈希索引（adaptive hash index ）、InnoDB存储的锁信息、
    数据字典信息等



