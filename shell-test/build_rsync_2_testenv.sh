#!/usr/bin/env bash


ROOT="/data/app-push/"

build_rsync_2_t0102() {
    t0102_srv_list=("ApnsEventCenter" "ApnsService" "MsgBroker" "XiaoMiPush" "Comet")
    for srv in ${t0102_srv_list[@]};do
        srv_dir="${ROOT}${srv}"
        echo "cd ${srv_dir} && go build && rsync -avP ${srv} t0102.eformax.com::temp"
        cd ${srv_dir} && go build && rsync -avP ${srv} t0102.eformax.com::temp
        if [ $? -eq 0 ];then
            echo -e "\033[32m${srv} update success\033[0m  \n+++++++++++++++++++++++++++++++++++++++++++++++++\n"
        else
            echo -e "\033[31m $srv build error! \033[0m"
            exit
        fi

    done;
}

build_rsync_2_t0110() {
    t0102_srv_list=("PushApi" "Comet")
    for srv in ${t0102_srv_list[@]};do
        srv_dir="${ROOT}${srv}"
        echo "cd ${srv_dir} && go build && rsync -avP ${srv} t0110.eformax.com::temp"
        cd ${srv_dir} && go build && rsync -avP ${srv} t0110.eformax.com::temp
        if [ $? -eq 0 ];then
            echo -e "\033[32m${srv} update success\033[0m  \n+++++++++++++++++++++++++++++++++++++++++++++++++\n"
        else
            echo -e "\033[31m $srv build error! \033[0m"
            exit
        fi

    done;
}

if [ "$1" == "t0102" ]; then
    build_rsync_2_t0102
elif [ "$1" == "t0110" ]; then
    build_rsync_2_t0110
else
    build_rsync_2_t0102
    build_rsync_2_t0110
fi
echo 'ok'
