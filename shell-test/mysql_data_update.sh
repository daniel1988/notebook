#!/usr/bin/env bash

mysql_user="root"
mysql_pwd="123456"

multi_refresh() {
    DATE_LIST=('2018-01-25' '2018-01-26' '2018-01-27')

    first_day=$(date -d "${DATE_LIST[0]} -1 day" +%Y-%m-%d)
    last_day=$(date -d "${DATE_LIST[-1]} -1 day" +%Y-%m-%d)

    echo "set time_zone='+8:00'; select count(0) AS count, from_unixtime(day) AS day from ${mysql_user}_base.stock_trade_info where day >=unix_timestamp('${first_day}') and day <=unix_timestamp('${last_day}') group by day ;"| mysql -u    ${mysql_user} -p${mysql_pwd} -S /tmp/mysql3306.sock

    for day in ${DATE_LIST[*]}; do
        mysql_day=$(date -d "${day} -1 day" +%Y-%m-%d)
        echo "set time_zone='+8:00'; select count(0), from_unixtime(day) from ${mysql_user}_base.stock_trade_info
        where day=unix_timestamp('${mysql_day}');" |
        mysql -u${mysql_user} -p${mysql_pwd} -S /tmp/mysql3306.sock


        echo "set time_zone='+8:00'; delete from ${mysql_user}_base.stock_trade_info
        where day=unix_timestamp('${mysql_day}');" |
        mysql -u${mysql_user} -p${mysql_pwd} -S /tmp/mysql3306.sock

        if [ $? -eq 0 ];then
                echo -e "\033[32m${mysql_day} delete success\033[0m  \n+++++++++++++++++++++++++++++++++++++++++++++++++\n"
                echo "curl -s 127.0.0.1:9510/StockData/getTrade?dt=${day}"
                curl -s 127.0.0.1:9510/StockData/getTrade?dt=${day}
        else
            echo -e "\033[31m ${mysql_day} delete error! \033[0m"
            return
        fi
    done


    while [ true ]; do
        echo "set time_zone='+8:00'; select count(0) AS count, from_unixtime(day) AS day from ${mysql_user}_base.stock_trade_info where day >=unix_timestamp('${first_day}') and day <=unix_timestamp('${last_day}') group by day ;" | mysql -u    ${mysql_user} -p${mysql_pwd} -S /tmp/mysql3306.sock
        sleep 2s
    done
}

refresh() {
    day=$(date -d "$1" +%Y-%m-%d)
    last_day=$(date -d "$1 +1 day" +%Y-%m-%d)
    echo $day $last_day

    echo "set time_zone='+8:00'; select count(0) AS count, from_unixtime(day) AS day from ${mysql_user}_base.stock_trade_info
        where day=unix_timestamp('${day}');" |
        mysql -u${mysql_user} -p${mysql_pwd} -S /tmp/mysql3306.sock

    echo "set time_zone='+8:00'; delete from ${mysql_user}_base.stock_trade_info
        where day=unix_timestamp('${day}');" |
        mysql -u${mysql_user} -p${mysql_pwd} -S /tmp/mysql3306.sock

    if [ $? -eq 0 ];then
        echo -e "\033[32m${day} delete success\033[0m  \n+++++++++++++++++++++++++++++++++++++++++++++++++\n"
        echo "curl -s 127.0.0.1:9510/StockData/getTrade?dt=${last_day}"
        curl -s 127.0.0.1:9510/StockData/getTrade?dt=${last_day}
    else
        echo -e "\033[31m ${day} delete error! \033[0m"
        return
    fi

    while [ true ]; do
        echo "set time_zone='+8:00'; select count(0) AS count, from_unixtime(day) AS day from ${mysql_user}_base.stock_trade_info
        where day=unix_timestamp('${day}');" |
        mysql -u${mysql_user} -p${mysql_pwd} -S /tmp/mysql3306.sock
        sleep 2s
    done
}

if [ $1 ];then
    echo -e "\033[32m++++++++++++++++++++++++refresh start++++++++++++++++++++++++\033[0m"
    refresh "$1"
    echo -e "\033[32m++++++++++++++++++++++++refresh end++++++++++++++++++++++++++\033[0m"
else
    echo -e "\033[32m++++++++++++++++++++++++multi_refresh start++++++++++++++++++\033[0m"
    multi_refresh
    echo -e "\033[32m++++++++++++++++++++++++multi_refresh end+++++++++++++++++++++\033[0m"
fi












