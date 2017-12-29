# Explain 语句


EXPLAIN tbl_name或：EXPLAIN [EXTENDED] SELECT select_options
前者可以得出一个表的字段结构等等，后者主要是给出相关的一些索引信息

```
 explain select * from customers ;
+----+-------------+-----------+------+---------------+------+---------+------+---------+-------+
| id | select_type | table     | type | possible_keys | key  | key_len | ref  | rows    | Extra |
+----+-------------+-----------+------+---------------+------+---------+------+---------+-------+
|  1 | SIMPLE      | customers | ALL  | NULL          | NULL | NULL    | NULL | 3569099 | NULL  |
+----+-------------+-----------+------+---------------+------+---------+------+---------+-------+

```

* id

select 查询的序列号

* select_type

select 查询的类型，主要是区别普通查询和联合查询、子查询之类的复杂查询

* table

输出的行所引用的表

## type

联合查询所使用的类型，type显示的是访问类型，是较为重要的一个指标，结果的好坏依次是：

```
system  > const > eq_ref > ref > fulltext > ref_or_null > index_merge > unique_subquery >
index_subquery > range > index > ALL
```

> 一般来说，得保证查询到至少达到range 的级别


* possible_keys

指出Mysql能使用哪个索引在该表中找到行，如果是空的，没有相关的索引，这时要提高性能，可通过检验
WHERE子句，看是否引用某些字段，或者检查字段不是适合索引。

* key

显示Mysql实际决定使用的键。如果滑索引被选择，键为NULL

* key_len

显示MySQL决定使用的键长度。如果键是NULL，长度就是NULL。文档提示特别注意这个值可以得出一个多重主
键里mysql实际使用了哪一部分。


* ref

显示哪个字段叵常数与key一起被使用

* rows

这个数表未mysql要遍历多少数据才能找到，在innodb上不准确

* Extra

如果是Only index 这意味着信息只用索引树中的信息检索出的，这比扫描整个表要快。
如果是where used 就是使用上了where限制
impossible where 表示用不着where 一般就是没有查出啥
如果此信息显示Using filesort或者Using temporary的话会很吃力，WHERE和ORDER BY的索引经常无法兼顾，如果按照
WHERE来确定索引，那么在ORDER BY时，就必然会引起Using filesort，这就要看是先过滤再排序划算，还是先排序再过滤划算