<?php



function sendTask( $task_id ) {
    $client = new swoole_client(SWOOLE_SOCK_TCP);
    //连接到服务器
    if (!$client->connect('127.0.0.1', 9509, 0.5))
    {
        echo "connect failed.\n" ;
    }

    if ( !$client->send($task_id ) ) {
        echo $task_id . "send failed\n";
    }
    //关闭连接
    $client->close();
}

swoole_timer_tick(1000, function ($timer_id) {
    $task_id = sprintf("task_id=%s&controller=%s&action=%s", date("His"),'xxxx', 'ooooo');
    echo date('Y-m-d H:i:s') . "----->{$task_id}\n";

    sendTask( $task_id );
});