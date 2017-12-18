
# 查某个进程的运行情况

```
top -p `pidof php-fpm | sed 's/ /,/g'`
```


# 查盾进程数
```
 ps -ef | grep php-fpm | wc -l
```

# 监控网络客户连接数

```
netstat -n | grep tcp | grep 80 | wc -l
```


# 查看物理CPU个数
```
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l
```