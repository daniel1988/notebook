
## php buffer 机制

默认开启，大小默认为4096(4kb), 在php.ini配置文件中，output_buffering配置．当php执行echo, print时，先将数据写入
buffer,当一个php buffer写满时，脚本进程会将php的buffer数据发送给系统的内核交由tcp传给浏览器显示


## 浏览器buffer

目前浏览器普遍为8000bytes (可以设置),只有输出数据达到这个长度或者脚本结束浏览器才会将数据输出在页面上


## 数据流程

echo/print ---> php buffer ---> tcp buffer(服务器系统buffer) ---> buffer ---> 浏览器展示


```
for($j = 1; $j <= 3; $j++) {

    echo "$j\n";
    flush();
    sleep(1); //一秒钟后继续执行
}
```

> 以上代码在客户端能每隔一秒刷新，网页上显示时会停几秒后全部显示

## 网页下载限速

可以通过，每隔一秒flush多少数据来进行限制下载速度

```
// 将发送到客户端的本地文件
$local_file = '/home/danielluo/Downloads/spa_achieve_collect_summary_201803.csv';
// 文件名
$download_file = 'xxx.csv';
// 设置下载速率(=> 20,5 kb/s)
$download_rate = 20.5;
if(file_exists($local_file) && is_file($local_file)) {
    // 发送 headers
    header('Cache-control: private');
    header('Content-Type: application/octet-stream');
    header('Content-Length: '.filesize($local_file));
    header('Content-Disposition: filename='.$download_file);
    // flush 内容
    flush();
    // 打开文件流
    $file = fopen($local_file, "r");
    while (!feof($file)) {
        // 发送当前部分文件给浏览者
        print fread($file, round($download_rate * 1024));
        // flush 内容输出到浏览器端
        flush();
        // 终端1秒后继续
        sleep(1);
    }
    // 关闭文件流
    fclose($file);
} else {
    die('Error: 文件 '.$local_file.' 不存在!');
}
```


