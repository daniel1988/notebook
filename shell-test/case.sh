#!/bin/bash

#break

cd /data/texmp && ls -l

if [ $? -eq 0 ]; then
    echo "success"
else
    echo "fail"
fi

# while :
# do
#     echo -n "Input a number between 1 to 5:"
#     read num
#     case ${num} in
#         1|2|3|4|5)echo "Your number is ${num}"
#         ;;
#         *) echo "You do not select a number between 1 to 5"
#             break
#         ;;
#     esac
# done