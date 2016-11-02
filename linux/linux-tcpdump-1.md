# tcpdump 实例


## tcpdump redis

* lo 代表127.0.0.1 即localhost
* eth0, eth1...分别代表网卡1、网卡2

> 抓取本机Redis set foo hello

```
$ sudo tcpdump -i lo -A -s2000 port 6379
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on lo, link-type EN10MB (Ethernet), capture size 200 bytes
```
```
127.0.0.1:6379> set foo hello
OK
```
```
14:02:17.827024 IP localhost.46361 > localhost.6379: Flags [P.], seq 3046771457:3046771490, ack 575618588, win 342, options [nop,nop,TS val 14614159 ecr 14612816], length 33
E..U..@.@.L................."O>....V.I.....
.......P*3
$3
set
$3
foo
$5
hello
```
> 当用redis-cli 连接时，即使不发送命令，为保持连接会每10秒发送redis-server的心跳包

```
14:10:08.963841 IP localhost.46361 > localhost.6379: Flags [.], ack 17, win 342, options [nop,nop,TS val 14731944 ecr 14728192], length 0
E..4..@.@.L................7"O>,...V.(.....
........
14:10:08.963866 IP localhost.6379 > localhost.46361: Flags [.], ack 55, win 342, options [nop,nop,TS val 14731944 ecr 14698171], length 0
E..4..@.@.w............."O>,...8...V.(.....
......F.

```
