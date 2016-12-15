<?php

class LogServer {

    var $server = null;

    var $host ='127.0.0.1';

    var $port = '9599';

    var $setting = [
        "worker_num"    => 4,
        "task_worker_num" => 4,
        "task_max_data" => 10000,
        "daemonize"     => false,
        "max_data"   => 10000,
        "dispatch_mode" => 2,
        "debug_mode"    => 1
    ];

    function __construct() {
        if ( class_exists("swoole_server") === false ) {
            die("need Swoole extension!!!!") ;
        }
    }

    function initLogServer( $host="127.0.0.1" , $port = "9599") {
        $this->host = $host ;
        $this->port = $port ;
        $this->server = new swoole_server( $this->host , $this->port , SWOOLE_PROCESS, SWOOLE_SOCK_UDP) ;

        $this->server->set($this->setting);
        $this->server->on("Start", [$this, "onStart"]);
        $this->server->on("managerStart", [$this, "onManagerStart"]);
        $this->server->on("workerStart", [$this, "onWorkerStart"]);
        $this->server->on("task", [$this, "onTask"]);
        $this->server->on("finish", [$this, "onFinish"]);
        $this->server->on("Receive", [$this, "onReceive"]);
        $this->server->on("Close", [$this, "onClose"]);
        $this->server->start();
    }

    /**
     * 启动Master
     * @param  [type] $server [description]
     * @return [type]         [description]
     */
    public function onStart( $server ) {
        $this->setProcessName("swoole-{$this->port}-master");
        echo sprintf("Server Start At: %s \n", date("Y-m-d H:i:s") );
    }

    /**
     * worker/task进程都是由Manager进程Fork并管理的
     */
    public function onManagerStart( $server ) {
        $this->setProcessName("swoole-{$this->port}-manager");
    }

    public function onWorkerStart( $server, $worker_id ) {
        if ($worker_id >= $this->setting['worker_num']) {
            $this->setProcessName("swoole-{$this->port}-task");
        } else {
            $this->setProcessName("swoole-{$this->port}-worker");
        }
    }

    public function onTask($server, $fd, $from_id, $data) {
        //返回任务执行的结果

        $log_file = 'log_' . date('ymd') . '.log';
        return file_put_contents($log_file, $data, FILE_APPEND);
    }
    /**
     * 处理异步结果
     */
    public function onFinish($server, $fd, $result) {

    }

    public function onConnect( $server, $fd ) {
        echo sprintf("Client connected.\n %s \n", var_export($fd, true ) ) ;
    }

    public function onReceive( $server , $fd, $from_id, $data ) {
        var_dump( $data ) ;
        $this->server->task($data);
    }

    public function onClose($server , $fd ) {
        echo sprintf("Client Close.\n %s \n", var_export($fd, true ) ) ;
    }

    public function setProcessName( $name ) {
        if ( function_exists('swoole_set_process_name') ) {
            return swoole_set_process_name( $name ) ;
        }

        if ( function_exists('cli_set_process_title') ) {
            return cli_set_process_title( $name ) ;
        }

        return false ;
    }
}

$tcpsrv = new LogServer();
$tcpsrv->initLogServer();