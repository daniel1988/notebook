# sed

## 简介
    sed是一种在线编辑器，它一次处理一行内容。处理时，把当前的行存储在临时缓冲区，称为“模式空间”(pattern space),
接着用sed命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。
文件内容并没有改变，除非你使用重定向存储输出。sed主要是用来编辑一个或者多个文件，简化对文件的反复。


## sed 使用参数
$ sed [-hnV][-e<file>][-f<file>][文本文件]
* 参数说明:
```
    -e<file>或--expression=<file> 以选项中指定的script来处理输入的文本文件
    -f<file>或--file=<file> 以选项中指定的script文件来处理输入的文本文件
    -n或--quiet或--silent 仅显示script处理后的结果
    -V或--version 显示版本信息
```

* 动作说明：
```
        a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
        c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
        d ：删除，d后面不带任何字符
        i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)
        p ：列印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行
        s ：取代，通常这个 s 的动作可以搭配正规表示法
```

## Demo 1
    以行为单位的新增／删除

```
$ nl /tmp/test.log | sed '2,2d'
     1  One line in the test log
     3  Three line in test test
```

```
$ nl /tmp/test.log | sed '2i hello world'
     1  One line in the test log
hello world
     2  Two line of test log
     3  Three line in test test
```

## Demo 2
    以行为单位的替换与显示
```
$ nl /tmp/test.log | sed '2,5c No 2-5 number'
     1  One line in the test log
No 2-5 number
     6  xxxxxxxxxxxxxxxxxxx
     7  offfffffffffffffff
```

## Demo 3
    数据搜寻并显示
```
$ nl /tmp/test.log | sed '/One/p'
     1  One line in the test log
     1  One line in the test log
     2  Two line of test log
```

## Demo 4
    数据搜寻并删除
```
$ nl /tmp/test.log | sed '/One/d'
     2  Two line of test log

```

## 数据搜寻并替换

> sed 's/replace_str/new_str/g'
```
$ ifconfig eth0 | grep 'inet addr' | sed 's/^.*addr://g' | sed 's/Bcast.*$//g'
10.1.16.36
```

##　多点编辑
`nl /etc/passwd | sed -e '3,$d' -e 's/bash/blueshell/'`

##　修改文件
```
$ sed -i '$a # This is a test' /tmp/test.log
$ cat /tmp/test.log
One line in the test log
Two line of test log
Three line in test test
xxxxxxxxxxxxxxxxxxx
offfffffffffffffff
# This is a test

```


[返回目录](https://github.com/daniel1988/notebook)