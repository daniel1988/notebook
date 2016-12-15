<?php

class TcpServer {

    var $server = null;

    function __construct() {
        if ( class_exists("swoole_server") === false ) {
            die("need Swoole extension!!!!") ;
        }
    }

    function initTcpServer( $host="127.0.0.1" , $port = "9501") {
        $this->server = new swoole_server( $host , $port ) ;
        $conf = [
            "worker_num"    => 4,
            "daemonize"     => false,
            "max_request"   => 10000,
            "dispatch_mode" => 2,
            "debug_mode"    => 1
        ];
        $this->server->set($conf);
        $this->server->on("Start", [$this, "onStart"]);
        $this->server->on("Connect", [$this, "onConnect"]);
        $this->server->on("Receive", [$this, "onReceive"]);
        $this->server->on("Close", [$this, "onClose"]);
        $this->server->start();
    }

    public function onStart( $server ) {

        echo sprintf("Server Start At: %s \n", date("Y-m-d H:i:s") );
    }

    public function onConnect( $server, $fd ) {
        echo sprintf("Client connected.\n %s \n", var_export($fd, true ) ) ;
    }

    public function onReceive( $server , $fd, $from_id, $data ) {
        echo sprintf("onReceive, From:%d, %s", $from_id, $data );

        $server->send($fd, "Server:" . $data);
    }

    public function onClose($server , $fd ) {
        echo sprintf("Client Close.\n %s \n", var_export($fd, true ) ) ;
    }
}

$tcpsrv = new TcpServer();
$tcpsrv->initTcpServer();