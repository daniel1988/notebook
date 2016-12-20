#!/usr/bin/python
from datetime import datetime
from elasticsearch import Elasticsearch
from elasticsearch import helpers
es = Elasticsearch("10.1.2.125:9200")
j = 0
count = 1000
actions = []
while (j < count):
    action = {
        "_index": "tickets-index",
        "_type": "tickets",
        "_id": j + 1,
        "_source": {
            "timestamp": datetime.now()}
    }
    actions.append(action)
    j += 1

    if (len(actions) == 100):
        print helpers.bulk(es, actions)
        del actions[0:len(actions)]

    if (len(actions) > 0):
        print helpers.bulk(es, actions)
        del actions[0:len(actions)]