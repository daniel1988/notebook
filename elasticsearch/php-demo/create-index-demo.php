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

// $response = $client->index($params);
// print_r($response);

$params = [
    'index' => 'my_index',
    'type' => 'my_type',
    'id' => 'my_id'
];

$response = $client->get($params);
print_r($response);