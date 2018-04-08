## swoole

PHP语言的高性能网络通信框架，提供了PHP语言的异步多线程服务器，异步TCP/UDP网络客户端，异步MySQL，数据库连接池，
AsyncTask，消息队列，毫秒定时器，异步文件读写，异步DNS查询。 Swoole虽然是标准的PHP扩展，实际上与普通的扩展不同。
普通的扩展只是提供一个库函数。而swoole扩展在运行后会接管PHP的控制权，进入事件循环。当IO事件发生后，swoole会自动
回调指定的PHP函数


## swoole_server

提供tcp/ucp server框架，多线程，eventloop，事件驱动，导步，worker进程组,task异步任务，毫秒定时器,ssl/tls隧道加密

## 进程分析

### Master进程

Master进程主要用于保证swoole框架机制的运行
* Reactor线程: 处理Tcp连接，收发数据．swoole主线程在Accept新的连接后，会将这连接分配给一个固定的Reactor线程，并由
该线程负责监听此socket．在socket可读时读取数据，并进行协议解析，将请求投递到worker进程．在socket可写时将数据
发送到tcp客户端
* Master线程: 负责新连接，Unix Proxi信号处理＼定时器任务．
* 心跳包检测线程
* Udp收包线程

### Manager进程

swoole中Worker/Task进程都是由Manager进程Fork并管理的
* 子进程结束运行时，manager进程负责回收此子进程，避免成为僵尸进程．并创建新的子进程
* 服务器关闭时，manager进程将发送信号给所有子进程，通知子进程关闭服务
* 服务器reload时, manager进程会关闭/重启子进程　
> 为什么不是Master进程, 主要原因是Master是多线程的，不能安全执行fork操作


### Worker进程

* 接收由Reactor线程投递的请求数据包，并执行php回调函数处理数据
* 生成响应数据并发给Reactor线程，由Reactor线程发送给Tcp客户端
* 可以是异步非阻塞模式　
* worker以多进程方式运行

> Swoole提供了完善的进程管理机制，当Worker进程异常退出，如发生PHP的致命错误、被其他程序误杀，
或达到max_request次数之后正常退出。主进程会重新拉起新的Worker进程。 Worker进程内可以像普通的
apache+php或者php-fpm中写代码。不需要像Node.js那样写异步回调的代码。

### Task进程　

* 接受由Worker进程通过　swoole_server->task/taskwait方法投递的任务
* 处理任务，并将结果数据返回worker进程
* 完全是同步阻塞模式
* Task以多进程的方式运行

> Task进程的全称是task_worker进程，是一种特殊的worker进程。所以onWorkerStart在task进程中也会被调用。
当`$worker_id >= $serv->setting['worker_num']`时表示这个进程是task_worker，否则，代表此进程是worker进程。