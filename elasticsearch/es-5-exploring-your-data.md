## The Search Api

[文档链接](https://www.elastic.co/guide/en/elasticsearch/reference/current/_the_search_api.html)

现在让我们开始几个简单的搜索，有两种基本的方法来搜索：一种是发送搜索参数通过REST　request　URI<br>
另一种是发送REST request body . request body 允许更多表达与更可读的json 格式来定义你的搜索项<br>
我们来试一个request URI的例子但本教程的其它部分，我们会用request body 方法。<br>

REST API搜索可以从_search端点，如以下例子返回银行的所有文档：<br>
> GET /bank/_search?q=*&sort=account_number:asc&pretty

```
{
  "took" : 63,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits" : {
    "total" : 1000,
    "max_score" : null,
    "hits" : [ {
      "_index" : "bank",
      "_type" : "account",
      "_id" : "0",
      "sort": [0],
      "_score" : null,
      "_source" : {"account_number":0,"balance":16623,"firstname":"Bradshaw","lastname":"Mckenzie","age":29,"gender":"F","address":"244 Columbus Place","employer":"Euron","email":"bradshawmckenzie@euron.com","city":"Hobucken","state":"CO"}
    }, {
      "_index" : "bank",
      "_type" : "account",
      "_id" : "1",
      "sort": [1],
      "_score" : null,
      "_source" : {"account_number":1,"balance":39225,"firstname":"Amber","lastname":"Duke","age":32,"gender":"M","address":"880 Holmes Lane","employer":"Pyrami","email":"amberduke@pyrami.com","city":"Brogan","state":"IL"}
    }, ...
    ]
  }
}
```
* took - Elasticsearch 执行搜索所花时间（毫秒）

* timed_out - 是否超时

* _shards - 搜索时用到多少个数据块，同样也是统计成功与失败多少个搜索块

* hits - 搜索返回结果

* hits.total - 与搜索标准匹配的文档总数

* sort - 结果集排序key ( 默认以score 排序)

* _score , max_score -

以上搜索用request body 方式：

```
GET /bank/_search
{
  "query": { "match_all": {} },
  "sort": [
    { "account_number": "asc" }
  ]
}
```

## Query Language

[文档链接](https://www.elastic.co/guide/en/elasticsearch/reference/current/_introducing_the_query_language.html)

你可以用Elasticsearch提供JSON风格的领域特性语言来执行查询。这就是我们提到的[Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)<br>
查询语言相当的全面当然不会一眼就能学会，最好的方法就是通过一些基础的例子来学习：<br>
>
```
GET /bank/_search
{
  "query": { "match_all": {} }
}
```
解析以上，query部分定义了要查询条件， match_all：查询索引中的所有文档

```
GET /bank/_search
{
  "query": { "match_all": {} },
  "size": 1
}
```
## 浅分页
>（默认情况下from+size>max_result_window（默认为10000） 会抛异常，可设置max_result_window，但查询会变慢

```
GET /bank/_search
{
  "query": { "match_all": {} },
  "from": 10,
  "size": 10
}
```

## 排序

```
GET /bank/_search
{
  "query": { "match_all": {} },
  "sort": { "balance": { "order": "desc" } }
}
```

## 只显示两个字段
```
GET /bank/_search
{
  "query": { "match_all": {} },
  "_source": ["account_number", "balance"]
}
```

##
```
GET /bank/_search
{
  "query": { "match": { "account_number": 20 } }
}
```

```
GET /bank/_search
{
  "query": { "match": { "address": "mill" } }
}
```

## bool Query
```
GET /bank/_search
{
  "query": {
    "bool": {
      "must": [
        { "match": { "age": "40" } }
      ],
      "must_not": [
        { "match": { "state": "ID" } }
      ]
    }
  }
}
```

## filter
```
GET /bank/_search
{
  "query": {
    "bool": {
      "must": { "match_all": {} },
      "filter": {
        "range": {
          "balance": {
            "gte": 20000,
            "lte": 30000
          }
        }
      }
    }
  }
}
```

## Aggregations (聚合)

聚合提供了组与提供统计数据的能力，你可以粗略理解为SQL中的group by 与 SQL的聚合函数，在elasticsearch，<br>
可以同时返回搜索结果hists与聚合的结果。<br>
>
```
GET /bank/_search
{
  "size": 0,
  "aggs": {
    "group_by_state": {
      "terms": {
        "field": "state.keyword"
      }
    }
  }
}
```

>注意：size为0是为了不显示搜索的结果，而只显示聚合的结果

相当于SQL:
>`SELECT state, COUNT(*) FROM bank GROUP BY state ORDER BY COUNT(*) DESC `

返回结果：
```
{
  "took": 29,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits" : {
    "total" : 1000,
    "max_score" : 0.0,
    "hits" : [ ]
  },
  "aggregations" : {
    "group_by_state" : {
      "doc_count_error_upper_bound": 20,
      "sum_other_doc_count": 770,
      "buckets" : [ {
        "key" : "ID",
        "doc_count" : 27
      }, {
        "key" : "TX",
        "doc_count" : 27
      }, {
        "key" : "AL",
        "doc_count" : 25
      }, {
        "key" : "MD",
        "doc_count" : 25
      }, {
        "key" : "TN",
        "doc_count" : 23
      }, {
        "key" : "MA",
        "doc_count" : 21
      }, {
        "key" : "NC",
        "doc_count" : 21
      }, {
        "key" : "ND",
        "doc_count" : 21
      }, {
        "key" : "ME",
        "doc_count" : 20
      }, {
        "key" : "MO",
        "doc_count" : 20
      } ]
    }
  }
}
```

在以上的基础上，计算平均值：


```
GET /bank/_search
{
  "size": 0,
  "aggs": {
    "group_by_state": {
      "terms": {
        "field": "state.keyword"
      },
      "aggs": {
        "average_balance": {
          "avg": {
            "field": "balance"
          }
        }
      }
    }
  }
}
```