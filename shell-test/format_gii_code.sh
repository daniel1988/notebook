#!/usr/bin/env bash

ROOT=$(cd "$(dirname "$0")"; cd ..; pwd)
CODE_DIR=("backend/controllers" "backend/models" "backend/views")

for dir in ${CODE_DIR[@]};do
    base_dir="${ROOT}/${dir}/"

    sed -i "s/ / /g" `grep " " -rl ${base_dir}`

    if [ $? -eq 0 ];then
        echo -e "\033[32m${base_dir} format success\033[0m"
    else
        echo -e "\033[31m ${base_dir} format error! \033[0m"
    fi
done
