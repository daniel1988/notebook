<?php
require 'vendor/autoload.php';

$hosts = [
    '10.1.2.125:9200'
];

$client = Elasticsearch\ClientBuilder::create()
            ->setHosts($hosts)
            ->build();

$params = [
    'index' => 'my_index',
    'type' => 'my_type',
    'id' => 'my_id',
    'body' => ['testField' => 'abc']
];

$params = [
    'index' => 'my_index',
    'type' => 'my_type',
    'id' => 'my_id'
];

$source = $client->getSource($params);
print_r( $source );