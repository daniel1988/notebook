#!/usr/bin/python

from elasticsearch import Elasticsearch

es = Elasticsearch(['10.1.2.125:9200'])

# ignore 400 cause by IndexAlreadyExistsException when creating an index
print es.indices.create(index='test-index', ignore=400)

# ignore 404 and 400
print es.indices.delete(index='test-index', ignore=[400, 404])