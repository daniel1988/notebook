#!/usr/bin/evn bash

echo -e "shell 字典\n"

declare -A dict

dict=(
    [red]="\033[31m 红色字 \033[0m"
    [yellow]="\033[34m 黄色字 \033[0m"
    [green]="\033[32m 绿色字 \033[0m"
    [blue]="\033[34m 蓝色字 \033[0m"
    [purple]="\033[35m 紫色字 \033[0m"
    [white]="\033[37m 白色字 \033[0m"
)

echo -e ${dict["red"]}

for key in $(echo ${!dict[*]})
    do
        echo -e "$key : ${dict[$key]}"
    done


key="red"
echo -e "key------>" ${dict[$key]}
