# 了解记录、字段与规则
    了解AWK语言的基础知识：记录、字段和规则

## AWK输入文件的组成部分
    AWK针对文本输入进行操作，而该文本可是一个文件或者标准输入流，它对文本进行分类　以得到记录和字段。
AWK记录是单个的、连续长度的输入数据，是AWK的操作对象。记录由记录分隔符限定，记录分隔符是一个字符串，
并且定义为RS变量。在缺省情况下，RS的值设置为换行符，所以AWK的缺省行为是将整行输入作为记录

## 规则
    AWK程序由规则组成，它们是一些模式，后面跟着换行符的操作，当AWK执行一条规则时，它在输入记录中搜索
给定模式的匹配项，然后对这些记录执行给定的操作：

    >ps: /pattern/ {action}

    可以在操作中省略模式或者操作。

    操作由awk语句组成，使用分号(;)来进行分隔。同一行内容中可提供多个规则，但必须使用分号对其分隔。
当规则中仅包含一项操作时，将对输入中每条记录执行操作。当规则中仅包含一个模式时，将打印出匹配该模式
的所有记录。
    空模式//匹配空字符，这等价于规则中不包含任何模式。然而给定空操作{}时，这并不等价于没任何操作。
空操作表示不进行任何操作（因此，不打印出该记录）

## 打印输入中的每个记录

    > //

    等价于：

    > {print}

```
$ awk '// {print}' test.log
    One line in the test log
    Two line of test log
    Three line in test test
$ awk '{print}' test.log
    One line in the test log
    Two line of test log
    Three line in test test
```

## 使用BEGIN 和END模式
    awk包含两种特殊的模式：BEGIN和END。他们都不需要使用斜线。BEGIN模式指定了在处理任何记录之前需要执行的操作：

    > BEGIN {action}

    END模式指定在处理所有记录之后需要执行的操作

    > END {action}

    BEGIN通常用来设置变量，而END通常用来对输入记录中读取的数据和图表进行制表、汇总和处理。通常这些模式可以用来在
    输出经过处理的文本之前和之后输出文本

```
$gawk 'BEGIN {print "Hello World!"} {print $0} END {print "byebye"}' test.log
Hello World!
One line in the test log
Two line of test log
Three line in test test
byebye
```
## 运行awk程序
    可以使用四种方法来运行awk程序：命令行中、作为筛选器、从文件或作为脚本　

### 在命令行中
```
$ ps -ef | grep nginx | gawk '{print}'
daniell+ 15757 32406  0 15:27 pts/28   00:00:00 grep --color=auto nginx
root     26885  2099  0 10月25 ?      00:00:00 nginx: master process /usr/sbin/nginx
www-data 26886 26885  0 10月25 ?      00:00:02 nginx: worker process
www-data 26887 26885  0 10月25 ?      00:00:04 nginx: worker process
www-data 26888 26885  0 10月25 ?      00:00:04 nginx: worker process
www-data 26890 26885  0 10月25 ?      00:00:02 nginx: worker process
```



### 目录
１、[gawk－简介](https://github.com/daniel1988/notebook/blob/master/linux/linux-gawk-1.md "linux-gawk")

２、[gawk－基础语法](https://github.com/daniel1988/notebook/blob/master/linux/linux-gawk-2.md "linux-gawk")

３、[gawk－运行、实例](https://github.com/daniel1988/notebook/blob/master/linux/linux-gawk-3.md "linux-gawk")