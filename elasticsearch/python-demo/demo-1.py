#!/usr/bin/python

from datetime import datetime
from elasticsearch import Elasticsearch
es = Elasticsearch(['10.1.2.125:9200'])

body = {
    "query":{
        "match_all":{}
    },
    "size":10
}
res = es.search(index="customer_assign_logs", body=body)
print("Got %d Hits:" % res['hits']['total'])
# for hit in res['hits']['hits']:
#     print hit