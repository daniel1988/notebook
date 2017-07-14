#!/usr/bin/env bash

RUBY_NOTIFY=`which notify`
if [ ! -f $RUBY_NOTIFY ]; then
    sudo apt-get install ruby-notify
fi

TITLE="温馨提示"
MESSAGE=`date`

if [ $(date +%M) -eq 30 ]; then
    TITLE="多喝水"
    MESSAGE=`date`
elif [ $(date +%H) -eq 18 ]; then
    TITLE="下班啦，加毛线班啊"
    MESSAGE=`date`
fi

export DISPLAY=:0.0 && notify-send  "$TITLE" "$MESSAGE"   ## export DISPLAY=:0.0　使前端显示
