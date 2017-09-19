## ES　multi-match

## Multi Match Query

multi_match 查询基于 match query ，允许多个字段的查询

```
GET /_search
{
  "query": {
    "multi_match" : {
      "query":    "this is a test",
      "fields": [ "subject", "message" ]
    }
  }
}
```

## 字段可以指定通配符

```
GET /_search
{
  "query": {
    "multi_match" : {
      "query" : "this is a test",
      "fields" : [ "subject^3", "message" ]
    }
  }
}
```

## multi_query 类型

* best_fields

默认类型，匹配所有字段用字段的_score来匹配最佳的字段


* most_fields

匹配文档中的字段包含查询的值

* cross_fields

把文档中所有字段当一个大字段来匹配，查询所有的字段里面的能匹配的值

* phrase / phrase_prefix






```
curl -XGET 10.1.1.20:9043/push/_search?pretty -d '
{
    "query": {
        "bool" : {
            "must" : {
                "multi_match": {
                    "type"  : "phrase",
                    "slop"  : 0,
                    "query" : "push测试，同事们莫慌",
                    'fields' : ["BodyList.Title"]
                }
            }
        }
    },
    "aggs" : {
        "Sended" : {
            "sum" : {
                "field" : "Sended"
            }
        },
        "Count" : {
            "cardinality" : {
                "field" : "Dest"
            }
        }
    }
}'
```