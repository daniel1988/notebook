#!/usr/bin/env bash

DAY_FORMAT="%Y-%m-%d"
SECOND_FROMAT="%Y-%m-%d %H:%M:%S"

demo(){
    while [true];do
        clear
        date "+%Y-%m-%d %H:%M:%S";
        sleep 1;
    done
}


demo2(){
    date +"${SECOND_FROMAT}";
    date -d "2018-01-29 -1 day" +%Y-%m-%d
    date -d "yesterday" +${DAY_FORMAT}
}


demo2