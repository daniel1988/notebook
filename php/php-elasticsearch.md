# php elasticsearch搜索

## 精确值查询

* term 查询

```
{
    "term" : {
        "price" : 20
    }
}
```



## PHP ES查询封装实例

```
/**
 * 查询文档可参考
 * https://www.elastic.co/guide/en/elasticsearch/reference/current/query-filter-context.html
 *     [
 *         ['match'  => ['uid'=>'111111']]
 *     ]
 *                     ['term'=>['batch_id'=>111]],
 *                     ['range'=>['field'=>['gt'=>0]]]
 *                 ]
 * @param  [type]  $index           []
 * @param  [type]  $must
 * @param  array   $filter          [
 * @param  array   $sort            [['field'=>['order'=>'desc']]]
 * @param  integer $page            [description]
 * @param  integer $limit           [description]
 * @return [type]  [description]
 */
function esQuery($index, $must, $filter = [], $sort = [], $page = 1, $limit = 10, $aggs=[])
{
    $cfg = config("es.{$index}");
    $param = [
        'index' => $cfg->index,
        // 'type' => $cfg->type,
        'body' => [
            'sort' => $sort,
            'query' => [
                'bool' => [
                    'must' => $must,
                    'filter' => $filter,
                ],
            ],
            'aggs'  => $aggs
        ],
    ];

    try {
        $res = service('esclient')->count($param);
        $record_count = isset($res['count']) ? $res['count'] : 0;
    } catch( Exception $e ) {
        $record_count = 0;
    }

    $current_record = ($page - 1) * $limit;
    if ($current_record < 0) {
        $current_record = 0;
    }
    if ($current_record >= $record_count) {
        $current_record = $record_count;
    }

    $page_count = ceil($record_count / $limit);

    if ($page >= $page_count) {
        $page = $page_count;
    }
    $param['body']['from'] = $current_record;
    $param['body']['size'] = $limit;
    try {
        $res = service('esclient')->search($param);
        $hits = isset($res['hits']['hits']) ? $res['hits']['hits'] : [];
    } catch (Exception $e) {
        $hits = [];
    }

    $item_list = [];
    foreach ($hits as $val) {
        $item_list[] = json_decode(json_encode($val['_source']));
    }

    $paginate = new \stdClass;
    $paginate->aggs = $res['aggregations'];
    $paginate->items = $item_list;
    $paginate->first = 1;
    $paginate->before = ($page >= 1) ? $page - 1 : 1;
    $paginate->current = ($page == 0) ? 1 : $page;
    $paginate->last = $page_count;
    $paginate->next = ($page < $page_count) ? $page + 1 : $page_count;
    $paginate->total_pages = $page_count;
    $paginate->total_items = $record_count;
    $paginate->limit = $limit;

    return $paginate;
}
```

```

if ( $msgid ) {
    $must[] = ['match'=> ['MsgID'=> $msgid]];
}

if ( $title ) {
    $must[] = [
        'multi_match'   => [
            'type'      => 'phrase',
            'slop'      => 0,
            'query'     => $title,
            'fields'    => ['BodyList.Title', 'BodyList.Content']
        ]
    ];
}
$esfilter       = [];
if ( $stime ) {
    if ( empty($etime) ) {
        $etime = date('Y-m-d', strtotime('tomorrow'));
    }
    $stime = str_replace('-', '', $stime). '000000000';
    $etime = str_replace('-', '', $etime) . '000000000';
    $esfilter[] = [
        'range' => [
            'NrTime' => [
                'gt'    => $stime,
                'lt'    => $etime
            ]
        ]
    ];
}

// $esfilter       = ['range'=>['Sended'=>['gt'=>0]]];

$sort[]         = ['NrTime'=>['order'=>'desc']];
```