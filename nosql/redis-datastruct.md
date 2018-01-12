## Redis　数据结构

Redis支持多种数据结构，如字符串(strings), 散列(hash), 列表(lists), 集合(sets), 有序集合(sorted sets) 与范围查询，
bitmaps, hyperloglogs, 地理空间geospatial索引半径查询

* Strings
    二进制安全字符串

* Lists
    按插入顺序排序的字符串元素的集合。他们基本上就是链表(linked lists)

* Sets
    不重复且无序的字符串元素的集合

* Sorted Sets
    类似Sets, 但每个字符串元素都关联到一个叫score浮云数值。里面的元素总是通过score进行排序，所以不同的是，
    它是可以检索一系列元素。

* Hashes
    由field和关联的value组成的map

* bitmaps
    或者说（simply bitmaps）通过特殊的命令，可以将string值当作一系列bits处理，可以设置和清除单独的bits，数出所有设为１的bits
    的数量，找到最前被设为1或０的bit

* HyperLogLogs
    这是被用于估计一个set 中元素数量的概率性数据结构。


## Redis Strings

Redis中最简单的数据类型

```
> set foo xxx
OK
> get foo
"xxx"
> setx foo 10
> type foo
string
```

## Lists

Redis Lists 是基于Linked Lists实现，不管list中有多少个元素，从头部或者尾部添加一个元素的操作，其时间复杂度也是常数级别的。

```
> rpush foolist A
(integer) 1
> rpush foolist B
(integer) 2
> lrange foolist 0 -1
1) "A"
2) "B"
```

> 常用案例：list可用于做聊天系统，或者不同进程间传递消息的队列

* List上的阻塞操作
    可以使用Redis来实现生产者与消费者模型，如使用Lpush与Rpop来实现该功能时，会遇到list为空，但消费者会一直轮询来获取数据。
    这样会增加Redis的访问压力、增加消费端的cpu时间。为此redis提供了BRpop与BLpop命令。


## Sets

Redis Sets 是string的无序排序。SADD指令把新的元素添加到set中。

```
> sadd myset 1 2 3
(integer) 3
> smembers myset
1) "1"
2) "2"
3) "3"
>scard myset        # 查看个数
(integer) 3
> sismember myset 3
(integer) 1
> sismember myset 30
(integer) 0
```

## Sorted Sets

有序集合有点像SET和Hash的一个混合，像集合一样，sorted sets由一些无重复的字符串元素组成

```
127.0.0.1:6379> zadd hackers 1988 "Daniel"
(integer) 1
127.0.0.1:6379> zadd hackers 1902 "XXXXX"
(integer) 1
127.0.0.1:6379> zrange hackers 0 -1
1) "XXXXX"
2) "Daniel"
```

> 默认为一个升序的排序，逆序如下


```
> zrevrange hackers 0 -1
1) "Daniel"
2) "XXXXX"

```

```
> zrange hackers 0 -1 withscores
1) "XXXXX"
2) "1940"
3) "Daniel"
4) "1988"
```

* zrangebyscore

    zrangebyscore key min max \[withscores\] \[limit offset count\]
```
redis> ZADD myzset 1 "one"
(integer) 1
redis> ZADD myzset 2 "two"
(integer) 1
redis> ZADD myzset 3 "three"
(integer) 1
redis> ZRANGEBYSCORE myzset -inf +inf
1) "one"
2) "two"
3) "three"
redis> ZRANGEBYSCORE myzset 1 2
1) "one"
2) "two"
redis> ZRANGEBYSCORE myzset (1 2
1) "two"
redis> ZRANGEBYSCORE myzset (1 (2
(empty list or set)
```

## bitmaps
bitmaps 不是一个真正的数据类型，而是一个定义于字符串类型的面向位操作的集合。由于字符串类型是二进制安全，最大的长度为512M
刚好可以设置2^32个不同的二进制位

```
> setbit key 10 1
(integer) 1
> getbit key 10
(integer) 1
> getbit key 11
(integer) 0
```