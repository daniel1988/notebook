## mysql 分表

mysql分表有两种方式，一种是mysql本身的分区表，另一种是在语言层面以相应的字段取模或者以特定的算法进行分表

### mysql 分区表

    mysql 分区表对用户而言就是一个独立的逻辑表，但是底层由多个物理表组成。实现分区的代码实际上是对一组底层表的句柄
对象的封装。对分区表的请求，都会通过句柄对象转化为存储引擎的接口调用。使用partition by 子句定义每个分区的数据存放

### 分区表应用场景

    * 表非常大以至于无法全部都放在内存中，或者只有表的最后部分有热点数据，其他都是历史数据
    * 分区表数据更容易维护
    * 数据可以分布在不同的物理设备上，从而高效地利用多个硬件设备
    * 可以使用分区表避免某些特殊的瓶颈，如innodb的单个索引的互斥访问，ext3文件系统的inode锁竞争等
    * 如果需要还可以血仇和恢复独立的分区，这在非常大的数据集的场景下效果非常好

### 分区表的限制

    * 一个表最多只能有1024个分区
    * 在msyql5.1中，分区表必须是整数，或者是返回整数的表达式。在mysql5.5中，某些场景可以直接使用列进行分区
    * 如果分区字段有主键或者唯一索引列，那么所有主键与唯一索引列必须包含进来
    * 分区表中无法使用外键约束

>注：分区表CRUD操作时会锁住所有底层表

### 逻辑分表

    采用特定的算法进行分表，如：uid%100 即把用户表分为100个表，一般数据量大了无法处理时还可以进行分库。
同样的道理，进行某一个特定的字段取模或者其它算法。

* 优点

    * 解决大中数据并发问题，CRUD时不会影响整个业务

* 缺点

    * 数据维护起来比较麻烦，如给出指定的uid找相应的信息，你还得自己去算出在哪个表。（不过很明显，这优点大于缺点）