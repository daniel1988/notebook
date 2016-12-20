#!/usr/bin/python

from datetime import datetime
from elasticsearch import Elasticsearch

client = Elasticsearch(['10.1.2.125:9200'])

# res = client.index(index="my-index", doc_type="test-type", id=42, body={"any": "data", "timestamp": datetime.now()})
# print res
#

# print client.get(index='my-index', doc_type="test-type", id=44)


res = client.search(index='my-index', body={
    "query":{
        "match_all":{}
    }
})


# for hit in res['hits']['hits']:
#     print hit['_source']


res = client.search(index='my-index', body={
    'query':{
        'match':{
            'title':'python2.7'
        }
    }
})
for hit in res['hits']['hits']:
    print hit['_source']