#!/bin/bash
#network

while true; do
  echo 'insert into db_test.test_1 values(null, 20161123);' | mysql -uroot -proot
done