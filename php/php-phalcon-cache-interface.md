# Phalcon Cache Interface

## 文件缓存

```
$frontCache = new Phalcon\Cache\Frontend\Output(
    [
        "lifetime" => 86400,
    ]
);

$cache = new Phalcon\Cache\Backend\File(
    $frontCache,
    [
        "cacheDir" => "/tmp/",
    ]
);
$content = $cache->start('cache.html');

if ($content === null) {
    echo date('r');
    $cache->save();
} else {
    echo $content;
}
```

```
$frontCache = new Phalcon\Cache\Frontend\Data(
    [
        "lifetime" => 86400,
    ]
);

$cache = new Phalcon\Cache\Backend\File(
    $frontCache,
    [
        "cacheDir" => "/tmp/",
    ]
);
$cache_key = 'cache_key.data';

$data = [
    'xxxx'  => 'ooo',
    '111'   => '222',
    'ooo'   => 'xxx'
];
$cache->save( $cache_key, $data );


var_dump( $cache->get($cache_key) ) ;
```

## Memcache

```
$frontCache = new Phalcon\Cache\Frontend\Data(array(
    "lifetime" => 86400
 ));
$cache = new Phalcon\Cache\Backend\Memcache($frontCache, array(
    'host' => 'localhost',
    'port' => 11211,
    'persistent' => false
 ));

$key = 'cache.key';
$data = [
    'aaa'   => 'bbb',
    'ccc'   => 'ddd'
];

$cache->save($key , $data ) ;

var_export( $cache->get( $key ) ) ;
```