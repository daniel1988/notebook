#!/usr/bin/env bash

read -t 10 -p "Input Your Name:" name
echo -e "\n"
echo "Your Name is :${name}"

read -t 10 -s -p "Please Input Your password:" passwd
echo -e "\n"
echo "Your Password is : ${passwd}"

read -t 10 -n 1 -p "Please Input Your Gender:" gender
echo "Gender is :${gender}"