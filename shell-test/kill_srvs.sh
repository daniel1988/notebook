#!/usr/bin/env bash
SRVS=("ApnsEventCenter" "ApnsService" "MsgBroker" "XiaoMiPush")
for srv in ${SRVS[@]}; do
    echo "kill ${srv} done!"
    kill -9 $(ps -ef|grep ${srv}|gawk '$0 !~/grep/ {print $2}' |tr -s '\n' ' ')
done;




