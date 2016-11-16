# Mysql 体系结构

* Mysql 由：SQL接口（连接池）、解析器、优化器、查询缓存、存储引擎　等组成

## SQL接口、连接池

* SQL接口：进行DML,DDL，存储过程，视图，触发器等操作和管理；用户通过SQL命令来查询所需要结果

* 连接池：管理用户的连接，线程管理等

```
mysql> show variables like '%connection%';
+--------------------------+-----------------+
| Variable_name            | Value           |
+--------------------------+-----------------+
| character_set_connection | utf8            |
| collation_connection     | utf8_general_ci |
| max_connections          | 151             |
| max_user_connections     | 0               |
+--------------------------+-----------------+
```

## 解析器

* Mysql将用户的查询语句进行验证与解析，并创建一个内部的数据结构--语法树
* 解析器由Lex和Yacc实现

```
mysql> show variables like 'optimizer_%';
+------------------------+------------------------------------------------------------------------------------------------------------------------+
| Variable_name          | Value                                                                                                                  |
+------------------------+------------------------------------------------------------------------------------------------------------------------+
| optimizer_prune_level  | 1                                                                                                                      |
| optimizer_search_depth | 62                                                                                                                     |
| optimizer_switch       | index_merge=on,index_merge_union=on,index_merge_sort_union=on,index_merge_intersection=on,engine_condition_pushdown=on |
+------------------------+------------------------------------------------------------------------------------------------------------------------+
```


## 优化器

* 访问路径的统计数据，进行各种优化，如：重写查询、选择读取表的顺序以及索引等

## 查询缓存

* 存储select 语句以及相应的结果集。在解析查询之前服务器会先访问查询缓存。如果命中缓存最不会进行解析、优化
直接将结果返回

* 一般的缓存有：表缓存、记录缓存、key缓存、权限缓存等

```
mysql> show variables like '%query_cache%';
+------------------------------+----------+
| Variable_name                | Value    |
+------------------------------+----------+
| have_query_cache             | YES      |
| query_cache_limit            | 1048576  |
| query_cache_min_res_unit     | 4096     |
| query_cache_size             | 16777216 |
| query_cache_type             | ON       |
| query_cache_wlock_invalidate | OFF      |
+------------------------------+----------+
```

## 存储引擎

* 存储引擎是Mysql与文件打交道的子系统。Mysql的存储引擎是插件式的，可根据MySql AB公司文件访问层来定制一种
访问机制（这种访问机制就叫存储引擎）


## SQL执行过程

>接受命令（用户验证、资源申请）、解析命令（SQL解析、生成语法树）、查询是否命中缓存、优化执行、执行（返回结果集）
