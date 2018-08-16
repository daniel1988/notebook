## linux日志查看

linux下日志查看命令有: cat / vim / tail / head / less / more / grep

## vim

vi/ vim 可分为三种状态: 1. 命令模式   2. 插入模式   3. 底行模式

* 命令行模式

    控制屏幕光标的移动,字符\字\或行的删除

    - Ctrl + f    向前翻屏
    - Ctrl + b    向后翻屏
    - Ctrl + d    向后翻半屏
    - Ctrl + u    向后翻半屏

* 底行模式

将文件保存或退出vim, 可以设置编辑环境,寻找字符串, 列出行号等

```
:set nu       # 设置行号
/xxxx         # 搜索xxxx

```

> 当日志文件大时,不适合用vim 来搜索日志


## cat

cat 命令是linux下文本输出命令,通常用来观看某个文件的内容

```
cat filename  # 查看整个文件

cat xxx.log | grep ooo    ## 查看xxx.log文件并搜索 ooo
```



## head

head 命令是从文件开头查看内容

```
head -n 100 xxx.log     #  查看xxx.log前面100行
```

## tail

tail 命令是从文件结尾查看内容

```
tail -f xxx.log      # 监视文件尾部内容 (默认为10行)    按ctrl + c 停止

tail -fn100 xxx.log   # 监视xxx.log 并查看最后100行内容

tail -n 100 xxx.log         # 打印文件最后100行

tail -n +100 xxx.log     #  打印100行以后所有数据
```

## 大文件日志搜索

比如搜索最近1天以内的日志, 可以用`tail -fn200000 xxx.log >/tmp/xx.log` 大概预估一下一天的数据量,重定向到新的文件后.
直接用vim 或者`cat /tmp/xx.log | grep ooo `搜索要查询的内容


如果需要搜索某一天的数据, 那就得用sed 先定位相应的数据行. 最后重定向到新文件查看

```
sed -n '1000,2000p' xxx.log     # 打印1000~2000行相应的数据

sed -n '10000, 20000p' xxx.log > /tmp/xx.log

cat /tmp/xx.log | grep ooo
```

> 注: 更复杂操作请查看 `awk 与 sed `

