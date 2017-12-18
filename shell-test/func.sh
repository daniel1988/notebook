#!/bin/bash

curl_info(){
    echo $1, $2
    sum=`expr $1 + $2`
    echo $sum
    return $sum
}

hello() {
    echo "hello world"
}

hello

curl_info 1 2