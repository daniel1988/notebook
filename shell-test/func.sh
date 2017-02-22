#!/bin/bash

curl_info(){
    echo $1, $2
    sum=`expr $1 + $2`
    echo $sum
    return $sum
}

curl_info 1 2