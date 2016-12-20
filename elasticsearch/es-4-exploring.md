
## Cluster Health
    [文档链接](https://www.elastic.co/guide/en/elasticsearch/reference/current/_cluster_health.html)

> 从基础的健康检查开始，通常可以检测出集群在干啥。我们可以用curl来做，当然也可以用其它的工具只要能发HTTP/REST 请求的就行。<br>
假设我们在同一个结点（服务器）我们运行Elasticsearch机器上，打开另一个shell 窗口。为了检查集群的健康，我一般用<strong>_cat API</strong><br>
你也可以在<strong>Kibana's Cosole</strong>点击"VIEW IN CONSOLE"　, 或者用curl 执行以下的链接

```
$ curl 127.0.0.1:9200/_cat/health?v
epoch      timestamp cluster       status node.total node.data shards pri relo init unassign pending_tasks max_task_wait_time active_shards_percent
1482217852 15:10:52  elasticsearch green           1         1      0   0    0    0        0             0                  -                100.0%
```
> 可以看到cluster 的名字为elasticsearch 的状态为"green"，　集群的状态有：green, yellow, red

* green: everything is good

* yellow: 所有数据都可用，但一些副本还没有分配

* red: 一些数据不可用不知道什么原因

> 当你的集群状态为red时，　部分功能还是可以用的（集群会继续从可用的碎片上返回请求），但是肯定需要修复ASAP，不然就会有数据包丢失<br>

> 从以上的返回可以看出，总共一个结点和０个碎片，因为暂时还没有数据。请注意，由于我们使用的是默认的群集名称（Elasticsearch）<br>
由于Elasticsearch采用单播网络发现默认情况下在同一台机器上找到其他节点。你可能会意外地启动一个以上的节点在您的计算机上，并让<br>
他们都加入一个单一的集群。在这种情况下，您可能会看到超过1个节点在上面的响应。
```
$ curl 127.0.0.1:9200/_cat/nodes?v
ip        heap.percent ram.percent cpu load_1m load_5m load_15m node.role master name
127.0.0.1            6          75  12    5.03    3.96     1.92 mdi       *      Bf5RaII
```

## 同时启动两个
```
$ bash elasticsearch &

$ bash elasticsearch &
```
> 呵呵，可以试一下



## 查看所有索引
```
$ curl 127.0.0.1:9200/_cat/indices?v
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
```
>　很简单，啥索引都没

## 创建索引
```
$ curl -XPUT 127.0.0.1:9200/customer?pretty
{
  "acknowledged" : true,
  "shards_acknowledged" : true
}
$ curl 127.0.0.1:9200/_cat/indices?v
health status index    uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   customer ahhBpVCYR6OIcaG_rf_bwg   5   1          0            0       650b           650b
```
> 第一个命令是创建一个名字为"customer"的索引用PUT，我们简单的加了一个pretty参数，是告诉服务器以打印返回的json串漂亮一点<br>

> 第二个命令的返回结果告诉我们，有一个名为customer的索引，５个主碎片和一个副本、０个文档<br>
你可以会注意到customer索引有一个yellow状态。上面我们说到yellow状态是有一些副本还没有分配。这个是因为es默认创建副本时，由于<br>
当前只有结点在跑，导致副本不能被分配（高可用性）直到添加另一个结点为止。一但添加另一个结点，该状态就会变为green



## Index and Query a Document - 创建与查询文档

```
$ curl -XPUT 127.0.0.1:9200/customer/external/1?pretty -d '
{
    "name": "Daniel Luo"
}'
```

返回：
```
{
  "_index" : "customer",
  "_type" : "external",
  "_id" : "1",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "created" : true
}
```

* 查询
```
$ curl -XGET 127.0.0.1:9200/customer/external/1?pretty
{
  "_index" : "customer",
  "_type" : "external",
  "_id" : "1",
  "_version" : 1,
  "found" : true,
  "_source" : {
    "name" : "Daniel Luo"
  }
}
```
> 这里没什么特别的东西，除了一个<strong>found</strong>, 说明我们用id 为1 找着一个文档，　其它的字段：_source，　返回的是一个json<br>
文档我们之前定义好的


## Delete an Index －删除索引

```
$ curl -XDELETE 127.0.0.1:9200/customer?pretty
{
  "acknowledged" : true
}

$ curl 127.0.0.1:9200/_cat/indices?v
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
```
> 这意味着成功删除了索引

```
PUT /customer
PUT /customer/external/1
{
  "name": "John Doe"
}
GET /customer/external/1
DELETE /customer
```
> 如果我们学习以上命令仔细一点，我们实际可以看出访问Elasticsearch模式：
`<REST Verb> /<Index>/<Type>/<ID>'

>以上REST访问模式贯穿了整个api命令


## Updating Documents

> 除了能够索引和替换文档，我们还可以更新文档，注意因为es并不是真正在一个地方更新，不管我们什么时候做一个更新，<br>
es都是删除老的文档，然后再创建新的文档
```
curl -XPOST 127.0.0.1:9200/customer/external/1/_update?pretty -d '
{
  "doc": { "name": "Jane Doe" }
}'
```


```
curl -XPOST 127.0.0.1:9200/customer/external/1/_update?pretty -d '
{
  "doc": { "name": "Jane Doe", "age": 20 }
}'
```
> 更新也可以用简单的脚本
```
curl -XPOST 127.0.0.1:9200/customer/external/1/_update?pretty -d '
{
  "script" : "ctx._source.age += 5"
}'
```
> 以上ctx._source 指当前更新的文档

> 注意：当前Elasticsearch只提供了单个文件的更新，将来可以会提供给一个条件更新多个文档（像一条SQL UPDATE-WHERE 语句）


## Batch Processing - 批量处理
* _bulk API
```
POST /customer/external/_bulk?pretty
{"index":{"_id":"1"}}
{"name": "John Doe" }
{"index":{"_id":"2"}}
{"name": "Jane Doe" }
```

```
POST /customer/external/_bulk?pretty
{"update":{"_id":"1"}}
{"doc": { "name": "John Doe becomes Jane Doe" } }
{"delete":{"_id":"2"}}
```
