<?php

//每隔2000ms触发一次
swoole_timer_tick(2000, function ($timer_id) {
    echo date('Y-m-d H:i:s') . "----->tick-2000ms\n";
});

//3000ms后执行此函数
swoole_timer_after(3000, function () {
    echo  date('Y-m-d H:i:s') . "----->after 3000ms.\n";
});