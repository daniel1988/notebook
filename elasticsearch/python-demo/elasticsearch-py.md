#elasticsearch-py

## Python ElasticSearch 客户端
* elasticsearch-py 是官方底层客户端-目标是在Python代码中提供共同的elasticsearch

* elasticsearch-dsl 是一个基于elasticsearch-py但是更pythonic库

##Demo_1
```
from datetime import datetime
from elasticsearch import Elasticsearch
es = Elasticsearch()

doc = {
    'author': 'kimchy',
    'text': 'Elasticsearch: cool. bonsai cool.',
    'timestamp': datetime.now(),
}
res = es.index(index="test-index", doc_type='tweet', id=1, body=doc)
print(res['created'])

res = es.get(index="test-index", doc_type='tweet', id=1)
print(res['_source'])

es.indices.refresh(index="test-index")

res = es.search(index="test-index", body={"query": {"match_all": {}}})
print("Got %d Hits:" % res['hits']['total'])
for hit in res['hits']['hits']:
    print("%(timestamp)s %(author)s: %(text)s" % hit["_source"])
```

## 长连接（持久连接-persistent connections）

* elasticsearch-py 在单个连接池中使用长连接（一个连接配制或者一个结点），连接池外你可以使用<br>
http/https来实现。

* 传输层每个结点会生成一个已选择的连接实例，并且会跟踪该结点是否正常。如果结点无反应（连接时<br>
抛异常）　连接池类会使该结点超时一直到该循环结束。默认情况下，节点在进入池之前是随机的，循环策略用于负载平衡.。



## Sniffing
```
from elasticsearch import Elasticsearch

# by default we don't sniff, ever
es = Elasticsearch()

# you can specify to sniff on startup to inspect the cluster and load
# balance across all nodes
es = Elasticsearch(["seed1", "seed2"], sniff_on_start=True)

# you can also sniff periodically and/or after failure:
es = Elasticsearch(["seed1", "seed2"],
          sniff_on_start=True,
          sniff_on_connection_fail=True,
          sniffer_timeout=60)
```

## Thread safety

* 默认情况下允许urllib3 每个结点可以开启10个连接。如果应用中需要更多可以用maxsize参数

```
# allow up to 25 connections to each node
es = Elasticsearch(["host1", "host2"], maxsize=25)
```

## SSL and Authentication

```
from elasticsearch import Elasticsearch

# you can use RFC-1738 to specify the url
es = Elasticsearch(['https://user:secret@localhost:443'])

# ... or specify common parameters as kwargs

# use certifi for CA certificates
import certifi

es = Elasticsearch(
    ['localhost', 'otherhost'],
    http_auth=('user', 'secret'),
    port=443,
    use_ssl=True
)

# SSL client authentication using client_cert and client_key

es = Elasticsearch(
    ['localhost', 'otherhost'],
    http_auth=('user', 'secret'),
    port=443,
    use_ssl=True,
    ca_certs='/path/to/cacert.pem',
    client_cert='/path/to/client_cert.pem',
    client_key='/path/to/client_key.pem',
)
```
