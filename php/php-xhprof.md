Xhprof

1、Xhprof安装
    * wget http://pecl.php.net/get/xhprof-0.9.4.tgz　　（有效）
    tar zxvf xhprof-0.9.4.tgz
    cd xhprof-0.9.4/extension/
    phpize

    ./configure --with-php-config=/usr/bin/php-config
    make
    make install
    (php-config需要根据自己配制而定)
    执行后会生成相应的拓展：
        Installing shared extensions:     /usr/lib/php5/20121212/

    * 修改php.ini 加入xhprof.so如果是拓展是分开配制的则在mods-available 目录下创建
        xhprof.ini
            extension = xhprof.so
    之后再到cli cgi fpm 的conf.d目录创建一个软链接　ln ../../mods-available/xhprof.ini xhprof.ini

    * 重启服务php-fpm
        kill -USR2 `cat /run/php-fpm.pid`

2、Xhprof php　运行
    * copy刚刚解压目录下的xhprof_html xhprof_lib　到相应的工程目录
    * example 目录下有一个sample.php样例可以直接运行
        但需要加入相应的常量
    * 把xhprof_lib/utils/config.sample.php 重命名为config.php

3、demo
<?php

function bar($x) {
  if ($x > 0) {
    bar($x - 1);
  }
}

function foo() {
  for ($idx = 0; $idx < 5; $idx++) {
    bar($idx);
    $x = strlen("abc");
  }
}

// start profiling
xhprof_enable();

// run program
foo();

// stop profiler
$xhprof_data = xhprof_disable();

// display raw xhprof data for the profiler run
print_r($xhprof_data);


define('XHPROF_ROOT' , dirname(__FILE__) ) ;
define( 'XHPROF_LIB_ROOT' , XHPROF_ROOT . '/xhprof_lib') ;

include_once XHPROF_ROOT . "/xhprof_lib/utils/xhprof_lib.php";
include_once XHPROF_ROOT . "/xhprof_lib/utils/xhprof_runs.php";
include_once XHPROF_LIB_ROOT . "/config.php" ;



// save raw data for this profiler run using default
// implementation of iXHProfRuns.
$xhprof_runs = new XHProfRuns_Default();

// save the run under a namespace "xhprof_foo"
$run_id = $xhprof_runs->save_run($xhprof_data, "xhprof_foo");
echo '<hr>' ;
echo "<a href='xhprof_html/index.php?run=$run_id&source=xhprof_foo'>show xhprof...</a>\n" ;
echo '<hr>' ;






