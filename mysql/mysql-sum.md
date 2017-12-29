


```
mysql> select sum(amount=1000) count from collect_invests where uid=2000235;
+-------+
| count |
+-------+
|     8 |
+-------+
1 row in set (0.00 sec)

mysql> select count(*) from collect_invests where uid=2000235 and amount=1000;
+----------+
| count(*) |
+----------+
|        8 |
+----------+
1 row in set (0.00 sec)

mysql> explain select sum(amount=1000) count from collect_invests where uid=2000235;
+----+-------------+-----------------+------+---------------+---------+---------+-------+------+-----------------------+
| id | select_type | table           | type | possible_keys | key     | key_len | ref   | rows | Extra                 |
+----+-------------+-----------------+------+---------------+---------+---------+-------+------+-----------------------+
|  1 | SIMPLE      | collect_invests | ref  | IDX_uid       | IDX_uid | 8       | const |   53 | Using index condition |
+----+-------------+-----------------+------+---------------+---------+---------+-------+------+-----------------------+
1 row in set (0.00 sec)

mysql> explain select count(*) from collect_invests where uid=2000235 and amount=1000;
+----+-------------+-----------------+------+---------------+---------+---------+-------+------+------------------------------------+
| id | select_type | table           | type | possible_keys | key     | key_len | ref   | rows | Extra                              |
+----+-------------+-----------------+------+---------------+---------+---------+-------+------+------------------------------------+
|  1 | SIMPLE      | collect_invests | ref  | IDX_uid       | IDX_uid | 8       | const |   53 | Using index condition; Using where |
+----+-------------+-----------------+------+---------------+---------+---------+-------+------+------------------------------------+
1 row in set (0.00 sec)

```


> 啥都不说，看下面..........

```
mysql> explain select sum(uid=2000235) from collect_invests;
+----+-------------+-----------------+-------+---------------+---------+---------+------+--------+-------------+
| id | select_type | table           | type  | possible_keys | key     | key_len | ref  | rows   | Extra       |
+----+-------------+-----------------+-------+---------------+---------+---------+------+--------+-------------+
|  1 | SIMPLE      | collect_invests | index | NULL          | IDX_uid | 8       | NULL | 754132 | Using index |
+----+-------------+-----------------+-------+---------------+---------+---------+------+--------+-------------+
1 row in set (0.00 sec)

mysql> explain select count(0) from collect_invests where uid=2000235;
+----+-------------+-----------------+------+---------------+---------+---------+-------+------+--------------------------+
| id | select_type | table           | type | possible_keys | key     | key_len | ref   | rows | Extra                    |
+----+-------------+-----------------+------+---------------+---------+---------+-------+------+--------------------------+
|  1 | SIMPLE      | collect_invests | ref  | IDX_uid       | IDX_uid | 8       | const |   53 | Using where; Using index |
+----+-------------+-----------------+------+---------------+---------+---------+-------+------+--------------------------+
1 row in set (0.00 sec)
```