# 简介
[文档链接](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html)
> ElasticSearch 是一个高效、可拓展的开源全文检索与数据分析引擎，它可以高效、接近时时的<br>
存储、检索、分析大数据。通常用于基础的引擎、技术应用于有复制的搜索与需求应用当中

# 应用场景
* 你运行一个网上在线商店，允许客户搜索你卖的产品。这种情况下，你可以用ES存储你全部产品目录、<br>
库存提供搜索、推荐等

* 你想收集日志或者事务数据，并且想要分析和挖掘这些数据的趋势、统计、总结、异常等。这样的场景，<br>
你可以用Logstash(Elasticsearch/Logstash/Kibana stack)来收集、合计、分析你的数据。然后再存储到ES<br>
一但这些数据存储到ES里面，你就可以搜索、合计你想的数据

* You run a price alerting platform which allows price-savvy customers to specify a rule like
"I am interested in buying a specific electronic gadget and I want to be notified if the price
of gadget falls below $X from any vendor within the next month". In this case you can scrape
vendor prices, push them into Elasticsearch and use its reverse-search (Percolator) capability
to match price movements against customer queries and eventually push the alerts out to the
customer once matches are found

* You have analytics/business-intelligence needs and want to quickly investigate, analyze, visualize,
and ask ad-hoc questions on a lot of data (think millions or billions of records). In this case,
you can use Elasticsearch to store your data and then use Kibana (part of the Elasticsearch/Logstash/Kibana stack)
to build custom dashboards that can visualize aspects of your data that are important to you. Additionally,
you can use the Elasticsearch aggregations functionality to perform complex business intelligence queries
against your data