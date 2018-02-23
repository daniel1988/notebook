#!/usr/bin/env bash

PHP5_DIR="/usr/bin/"
PHP7_DIR="/usr/local/php7/bin/"
PHP_DIR=""

if [ "$1" == "php7" ]; then
    PHP_DIR=${PHP7_DIR}
else
    PHP_DIR=${PHP5_DIR}
fi

echo "Change PHP Version To:$1"

CMD=("php" "php-config" "php-cgi" "phpize")


USR_LOCAL="/usr/local/bin/"

for command in ${CMD[*]};do

    SOURCE_FILE="${PHP_DIR}${command}"

    TARGET_FILE="${USR_LOCAL}${command}"

    sudo rm -f ${TARGET_FILE} && sudo ln -s ${SOURCE_FILE} ${USR_LOCAL}
    if [ $? -eq 0 ];then
            echo -e "\033[32m${command} update success\033[0m  \n"
    else
        echo -e "\033[31m ${command} update error! \033[0m"
        exit
    fi
done;


 echo -e "\033[32mChange PHP Version Success\033[0m  \n+++++++++++++++++++++++++++++++++++++++++++++++++"
 php -v
 echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++\n"
