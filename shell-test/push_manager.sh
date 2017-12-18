#!/usr/bin/env bash

srv_list=("ApnsEventCenter" "ApnsService" "MsgBroker" "XiaoMiPush")

if [ $1 = 'show' ];then
    for srv in ${srv_list[@]}; do
        ps -ef | grep ${srv}|grep -v grep
    done;
fi

if [ $1 = 'kill' ];then
    for srv in ${srv_list[@]}; do
        echo "kill ${srv} done!"
        kill -9 $(ps -ef|grep ${srv}|gawk '$0 !~/grep/ {print $2}' |tr -s '\n' ' ')
    done;
fi