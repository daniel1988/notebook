## 查询缓存

很多数据库产品能够缓存的执行计划，对于相同类型的SQL就可以跳过SQL解析和执行计划生成阶段。MYSQL缓存完整的SELECT 查询结果。
当查询命中缓存时，立刻返回结果，跳过了解析、优化和执行阶段。


## MySQL如何判断缓存命中

Mysql 缓存存放在一个引用表中，通过一个哈希值引用，这个哈希值包括：查询本身、当前要查询的数据库、客户端协议的版本等一些
其他可能会影响 返回结果的信息。


* 如何判断是否命中

    1. 空格、注释等任何不同都会导致缓存不命中。
    2. 查询语句中一些不确定的数据时，也不会被缓存。如：NOW()或者current_date()等任何用户自定义的函数、存储函数、用户变量
    临时表、mysql系统表、或者任何包含列级别的权限的表，都不会缓存。


## 优缺点

Mysql查询缓存在很多时候可以提升查询性能，但打开查询缓存对读和写操作都会带来额外的消耗

* 缺点

    1. 读查询在开始之前必须先检查是否命中缓存
    2. 如果这个读查询可以被缓存，那么当完成执行后，MySQL若发现查询缓存中没有这个查询，会将其结果存入查询缓存中，这会带来额外
    的系统消耗
    3. 对写操作也会有影响，因为当向某个表写入数据时，Mysql必须将对应表的所有缓存都设置失效。如果查询缓存非常大或者碎片很多，
    这个操作可能会带来很大系统消耗

> 对InnoDB用户来说，事务的一些特性会限制查询缓存的使用。当一个语句在事务中修改某个表，Mysql会将这个表的对就的查询缓存都设置失效
而事实上，InnoDB的多版本特性会暂时将这个修改对其他事务屏蔽。在这个事务提交之前，这个表的相关查询是无法被缓存的，所以所有在这个
表上面的查询——内部或外部的事务都只能在该事务提交后才被缓存。


> 如果查询缓存使用了很大量的内存，缓存失效操作就可能成为一个非常严重的问题瓶颈。


## 查询缓存如何使用内存

查询缓存是完全存储在内存中的，除了缓存查询结果之外，还需要缓存很多别的维护相关的数据（40KB）。Mysql查询缓存的内存被分成一个个
数据块，数据块是变长的。每个数据块中，存储了自己的类型、大小和数据本身，还外加指向前一个和后一个数据块的指针。

> 数据块的类型有：查询结果、查询数据表的映射、查询文本等。不同的存储块在内存使用上并没有什么不同，从用户角度来看无须区分

当查询结果需要缓存时，MySQL先从大的空间块中申请一个至少`query_cache_min_res_unit`的配置值数据块用于存储结果。因此，Mysql无法
为每个查询精确分配内存。


## 如何配置和维护查询缓存

* query_cache_type

    是否打开查询缓存。可以设置成OFF、ON或DEMAND (表未只有在查询语句中明确写明SQL_CACHE的语句才放入查询缓存)

* query_cache_size

    查询缓存使用的总内存空间，单位是字节。(必须为1024的整数倍，否则实际分配数据会和你指定不同)

* query_cache_min_res_unit

    在查询缓存中分配内存块时的最小单位。

* query_cache_limit

    Mysql 能够缓存的最大查询结果。如果查询结果大于这个值则不会被缓存。

* query_cache_wlock_invalidate

    如果某个数据表被其他的连接锁住，是否仍然从查询缓存中返回结果。（默认为OFF）