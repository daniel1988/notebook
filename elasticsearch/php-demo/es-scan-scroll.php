<?php
require 'vendor/autoload.php';

$hosts = [
    '10.1.2.125:9200'
];

$client = Elasticsearch\ClientBuilder::create()
            ->setHosts($hosts)
            ->build();


$params = [
    'search_type'   => 'scan',
    'scroll'        => '1m',
    'index'         => 'xxxx-crm-assign-logs',
    'type'      => 'customer_assign_logs',
    'body'      => [
        "query" => [
            "match_all" => []
        ]
    ]
];

$docs = $client->search($params);   // Execute the search
$scroll_id = $docs['_scroll_id'];   // The response will contain no results, just a _scroll_id
// while (true) {

    // Execute a Scroll request
    $response = $client->scroll([
            "scroll_id" => $scroll_id,  //...using our previously obtained _scroll_id
            "scroll" => "1m"           // and the same timeout window
        ]
    );

    print_r( count($response['hits']['hits'] )) ;
// }