#!/usr/bin/env bash

ROOT="/data/app-push/"

TODAY=$(date "+%Y%m%d")

PUBDIR="/data/publish/${TODAY}/"

echo $(date)
if [ ! -d "${PUBDIR}" ]; then
    mkdir -p ${PUBDIR}
    echo -e "\033[32m mkdir ${PUBDIR} success\033[0m"
fi

# services=("ApnsEventCenter" "ApnsService" "MsgBroker" "XiaoMiPush" "Comet" "PushApi" "Comet" "AuthenticationProxy")
services=("ApnsEventCenter" "ApnsService" )
for service in ${services[@]};do

    service_dir="${ROOT}${service}"
    echo "cd ${service_dir} && go build && cp ${service} ${PUBDIR}"
    cd ${service_dir} && go build && cp -rf ${service} $PUBDIR

    if [ $? -eq 0 ];then
        echo -e "\033[32m${service} build success\033[0m  \n+++++++++++++++++++++++++++++++++++++++++++++++++\n"
    else
        echo -e "\033[31m ${service} build error! \033[0m"
        exit
    fi

done;

echo "cd $PUBDIR && rm -f ${PUBDIR}*.tar.gz && tar -zcvf \"${TODAY}.tar.gz\" *"
cd $PUBDIR && rm -f ${PUBDIR}/*.tar.gz && tar -zcvf "${TODAY}.tar.gz" *

if [ $? -eq 0 ];then
    echo -e "\033[32mpack services success\033[0m  \n+++++++++++++++++++++++++++++++++++++++++++++++++\n"
else
    echo -e "\033[31mpack services  error! \033[0m"
    exit
fi

