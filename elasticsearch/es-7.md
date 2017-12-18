# ES　查询

## 精确值查找

当进行精确值查找时，我们使用过滤器(filters)。过滤器执行的速度非常快，不会计算相关度
(直接跳过整个评分阶段)而且很容易被缓存。

* term 查询

```
curl -XGET 10.1.1.102:9261/push/_search?pretty -d '
{
    "query": {
        "term": { "UserID": "3557888" }
    }
}'
```

* 布尔过滤器

```
{
   "bool" : {
      "must" :     [],
      "should" :   [],
      "must_not" : [],
   }
}
```

```
curl -XGET 10.1.1.20:9043/push/_search?pretty -d '
{
    "query": {
        "bool" : {
            "must" : {
                "term": { "UserID": "3001561" }
            },
            "filter" : {
                "match": { "AppName": "Loan.inhouse" }
            }

        }

    }
}'
```

* 查询多个精确值

```
{
    "terms" : {
        "price" : [20, 30]
    }
}
```

## 范围查询

* 范围

```
"range" : {
    "price" : {
        "gte" : 20,
        "lte" : 40
    }
}
```

* 日期范围

```
"range" : {
    "timestamp" : {
        "gt" : "2014-01-01 00:00:00",
        "lt" : "2014-01-07 00:00:00"
    }
}
```

* 字符串范围

```
"range" : {
    "title" : {
        "gte" : "a",
        "lt" :  "b"
    }
}
```

## 匹配

```
{
    "query": {
        "match": {
            "title": "BROWN DOG!"
        }
    }
}
```

* 提高精度

```
{
    "query": {
        "match": {
            "title": {
                "query":    "BROWN DOG!",
                "operator": "and"
            }
        }
    }
}
```

* 控制精度

```
{
  "query": {
    "match": {
      "title": {
        "query":                "quick brown dog",
        "minimum_should_match": "75%"
      }
    }
  }
}
```

## 组合查询

```
GET /my_index/my_type/_search
{
  "query": {
    "bool": {
      "must":     { "match": { "title": "quick" }},
      "must_not": { "match": { "title": "lazy"  }},
      "should": [
                  { "match": { "title": "brown" }},
                  { "match": { "title": "dog"   }}
      ]
    }
  }
}
```

* 控制精度

```
{
  "query": {
    "bool": {
      "should": [
        { "match": { "title": "brown" }},
        { "match": { "title": "fox"   }},
        { "match": { "title": "dog"   }}
      ],
      "minimum_should_match": 2
    }
  }
}
```

* 查询语句提升权重

```
{
    "query": {
        "bool": {
            "must": {
                "match": {
                    "content": {
                        "query":    "full text search",
                        "operator": "and"
                    }
                }
            },
            "should": [
                { "match": {
                    "content": {
                        "query": "Elasticsearch",
                        "boost": 3
                    }
                }},
                { "match": {
                    "content": {
                        "query": "Lucene",
                        "boost": 2
                    }
                }}
            ]
        }
    }
}
```
> boost参数被用来提升一个语句的相对权重(boost值大于1)或者降低相对权重(0<boost<1)，但是这种提升
或降低并不是线性的，换句话说，如果一个boost值为2,并不能获得两倍的评分_score

* 多字符串查询

```
GET /_search
{
  "query": {
    "bool": {
      "should": [
        { "match": { "title":  "War and Peace" }},
        { "match": { "author": "Leo Tolstoy"   }}
      ]
    }
  }
}
```

## Multi_match查询

```
{
    "multi_match": {
        "query":                "Quick brown fox",
        "type":                 "best_fields",
        "fields":               [ "title", "body" ],
        "tie_breaker":          0.3,
        "minimum_should_match": "30%"
    }
}
```

* 模糊匹配

```
{
    "multi_match": {
        "query":  "Quick brown fox",
        "fields": "*_title"
    }
}
```

```
GET /my_index/my_type/_search
{
    "query": {
        "match_phrase": {
            "title": {
                "query": "quick fox",
                "slop":  1
            }
        }
    }
}
```