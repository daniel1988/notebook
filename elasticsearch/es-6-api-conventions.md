# API 规范

## 多索引

引用索引参数的大多数api都支付跨多个索引， 用简单的test1,test2,test3标记（或者 _all 所有索引），同样支持通配符<br>
如：test* / *test / te*t  <br>
还有(+) 和(-) <br>
如：+test*, -test3<br>
所有多索引api 都支持以下url query string 参数

* ignore_unavailable

    控制是否忽略指定的索引不可用，这包括不存在的索引与已关闭的索引，可以指定true和false

* allow_no_indices

    控制通配符表达式为索引没有具体的索引是否失败，可以指定true,false ，如：指定foo* ，如果没有以foo开头的索引，<br>
    这就要看配制请求是否失败。这样配制也可以应用当 _all , * 或者没有指定索引时，此配制也适用于别名，如果别名没有<br>
    指向关闭的索引的话

* expand_wildcards

    控制具体的索引通配符扩展。 如果指定为open 那么通配符表达式只在打开的索引中扩展，如果是closed就只针对已关闭的索引<br>
    如果指定两个（open,closed）则可以应用到所有索引

如果指定为 none ，那么通配符就不可用，如果指定为 all 就可以应用于所有索引（这等于是：open, closed），以上默认的设置<br>
取决于正在使用的API


## 索引名支持日期计算

[文档链接](https://www.elastic.co/guide/en/elasticsearch/reference/current/date-math-index-names.html)

日期计算索引名可以搜索一系列时间序列的索引，而不是搜索所有时间序列的索引后过滤结果集或者维护一份别名。限制你搜索的索引<br>
数量可以减少集群的负载和提升执行的性能。如：你要在你的每日日志中搜索错误日志，你可以用日期计算命名模板来限制你搜索的<br>
最近两天.

基本上所有的api 都可以用 index 参数，支持日期来做索引的参数值：<br>

>`<static_name{date_math_expr{date_format|time_zone}}>`

* static_name - 名称的静态文本部分

* date_math_expr - 动态计算日期的动态日期表达式

* date_format - 计算日期应呈现的可选格式.。默认yyyy.mm.dd。

* time_zone - 时区， 默认为utc


你必须附上日期数学索引名称的表达式在尖括号，和所有的特殊字符应该URI编码。例如:
```
GET /<logstash-{now/d}>/_search
GET /%3Clogstash-%7Bnow%2Fd%7D%3E/_search
{
  "query" : {
    "match": {
      "test": "data"
    }
  }
}
```

## 常用选项

* Pretty Results

如果请求加上 ?pretty=true ，返回的json会格式化（仅用于调试用），另外一个选项是<br>
?format=yaml 以yaml的格式返回

* Human readable output

统计数据以适合人类的格式返回（"exists_time":"1h" 或者 "size":"1kb"） ，对计算机（"exists_time_in_millis":"3600000"<br>
或者 "size_in_bytes":1024），如果加上 ?human=false 则关闭人类可读。 这个选项对于监控工具来说是有道理的而不是人类消费<br>
默认的设置为false

* Date Math

很多参数中接收日期值，如：range 查询时 gt and lt , 或者daterange : from 和to<br>
表达式以一个日期锚点开始，也就是说可以用now ,或者一个日期字符串以||. 结尾<br>
锚点日期可以任选一个或多个数学表达式

    * +1h - 加一个小时
    * -1d - 减一天
    * /d  - 到最近的一天

支持的时间单位不同于时间单位所支持的持续时间。所支持的单位是

y               years
----
M               months
----
w               weeks
----
d               days
----
H               hours
----
m               minutes
----
s               seconds

如：

now+1h          当前时间加一个小时
----
now+1h+1m       当前时间加一个小时加一分钟
----
now+1h/d        当前时间加一个小时到最近一天的时间
----
2015-01-01||+1M/d  2015-01-01 加一月，到最近一天


## Response Filtering 返回过滤

所有REST API接收一个　filter_path 参数用来减少返回数据。此参数需要用圆点符号表示的逗号分隔的筛选器列表

>GET /_search?q=elasticsearch&filter_path=took,hits.hits._id,hits.hits._score

```
{
  "took" : 3,
  "hits" : {
    "hits" : [
      {
        "_id" : "0",
        "_score" : 1.6375021
      }
    ]
  }
}
```

>GET /_cluster/state?filter_path=metadata.indices.*.stat*
```
{
  "metadata" : {
    "indices" : {
      "twitter": {"state": "open"}
    }
  }
}
```

>GET /_cluster/state?filter_path=routing_table.indices.**.state
```
{
  "routing_table": {
    "indices": {
      "twitter": {
        "shards": {
          "0": [{"state": "STARTED"}, {"state": "UNASSIGNED"}],
          "1": [{"state": "STARTED"}, {"state": "UNASSIGNED"}],
          "2": [{"state": "STARTED"}, {"state": "UNASSIGNED"}],
          "3": [{"state": "STARTED"}, {"state": "UNASSIGNED"}],
          "4": [{"state": "STARTED"}, {"state": "UNASSIGNED"}]
        }
      }
    }
  }
}
```

>GET /_count?filter_path=-_shards
```
{
  "count" : 5
}
```

## Flat Settings 单位设置

当flat_settings 设置为true 时，返回设置列表

>GET twitter/_settings?flat_settings=true
```
{
  "twitter" : {
    "settings": {
      "index.number_of_replicas": "1",
      "index.number_of_shards": "1",
      "index.creation_date": "1474389951325",
      "index.uuid": "n6gzFZTgS664GUfx0Xrpjw",
      "index.version.created": ...,
      "index.provided_name" : "twitter"
    }
  }
}
```

flat_settings 设置为false 时，返回一个人类更可读的结构

>GET twitter/_settings?flat_settings=false

```
{
  "twitter" : {
    "settings" : {
      "index" : {
        "number_of_replicas": "1",
        "number_of_shards": "1",
        "creation_date": "1474389951325",
        "uuid": "n6gzFZTgS664GUfx0Xrpjw",
        "version": {
          "created": ...
        },
        "provided_name" : "twitter"
      }
    }
  }
}
```