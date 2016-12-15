<?php

class LogClient {

    var $client = null ;

    var $host = '127.0.0.1';

    var $port = '9599';

    var $timeout = 0.5;

    function initLogClient( $host = '127.0.0.1', $port = 9599, $timeout = 0.5 ) {
        $this->host = $host ;
        $this->port = $port ;
        $this->timeout = $timeout ;

        if ( !class_exists('swoole_client') ) {
            die('Need Swoole extension!!!!');
        }
        if ( $this->client ) {
            return $this->client ;
        }
        try {
            $this->client = new swoole_client(SWOOLE_SOCK_UDP);
            $this->client->connect($this->host, $this->port, $this->timeout);
        } catch( Exception $e ) {
            die( var_export( $e->getMessage(), true ) );
        }
        return $this->client;
    }

    function send( $data ) {
        if ( $this->initLogClient() === false ) {
            return false ;
        }
        return $this->client->send( $data ) ;
    }


    function debug() {
        $debug_arr = debug_backtrace();
        arsort( $debug_arr ) ;
        $data = "";
        $args = func_get_args();
        foreach( $debug_arr as $val ) {
            if ( isset( $val['file'] ) ) {
                $data .= '[' . date('Y-m-d H:i:s') . ']';
                $data .= $val['file'] . ':' . $val['line'] . ' ' ;
                $data .= isset( $val['class'] ) ? $val['class'] : ' ';
                $data .= "::";
                $data .= isset( $val['function'] ) ? $val['function'] : '' ;
                $data .="\n";
            }
        }
        $data .= var_export($args, true). "\n";
        echo $data ;
        return $this->send( $data ) ;
    }

}



class A {

    function testfoo($a='oooo') {
        $data = [1,2,23,2,2,22];
        $log_client = new LogClient();
        $log_client->debug('testfoo', $data) ;
    }
}


swoole_timer_tick(10, function ($timer_id) {
    $a = new A();
    $a->testfoo();
});