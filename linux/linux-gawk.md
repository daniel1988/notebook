## 如何kill掉进程名包含某个字符串的一批进程:

    kill -9 $(ps -ef|grep swooleServ-9530|gawk '$0 !~/grep/ {print $2}' |tr -s '\n' ' ')



## 观测进程名包含某个字符串的进程详细信息:

    top -c -p $(ps -ef|grep swooleServ-9510|gawk '$0 !~/grep/ {print $2}' |tr -s '\n' ','|sed 's/,$/\n/')


## gawk 命令：
* gawk是unix中原awk的gun版本
* 主要功能是处理文件文件中数据的能力　，通过自动将变量分配给第行中的每个数据元素实现这一功能*
    * $0　表示整行文本
    * $1 表示文本中第1个数据字段
    * $n 表示文本中第n个数据字段

* gawk命令格式
    * Usage: gawk [POSIX or GNU style options] -f progfile [--] file ...
    * Usage: gawk [POSIX or GNU style options] [--] 'program' file ...

## gawk选项
        -F fs
            指定描绘一行中数据字段的文件分隔符
        -f file
            指定读取程序的文件名
        -v var=value
            定义gawk程序中使用的变量和默认值
        -mf N
            指定数据文件中要处理的字段的最大数目
        -mr N
            指定数据文件中的最大记录大小
        -W keyword
            指定gawk的兼容模式或警告级别

## Demo 1
* $ cat test.log
>    One line in the test log
>    Two line of test log
>    Three line in test test

* $ gawk '{print $1}' test.log
>   One
>   Two
>   Three

## Demo 2
* $ gawk -F: '{print $1}' /etc/passwd
>    root
>    daemon
>   bin
>    sys
>    sync
>    games

## Demo 3
+ $ gawk 'BEGIN {print "Hello World!"} {print $0} END {print "byebye"}'
>   Hello World!
>   hello,,,        输入文本
>   hello,,,        ctrl-D
>   byebye


## BEGIN关键字是在处理任何数据之前应用的命令
* gawk数据字段和记录变量
        FIELDWIDTHS
            以空格分隔的数字列表，用空格定义每个数据字段的精确宽度
        FS
            输入字段分隔符号
        RS
            输入记录分隔符号
        OFS
            输出字段分隔符号
        ORS
            输出记录分隔符号
## Demo 4
+ $ cat data.log
    a,b,c
    a,b,c
+ $ gawk 'BEGIN{FS=",";OFS="#"} {print $1,$2,$3}' data.log
    a#b#c
    a#b#c

## gawk内置变量
        ARGC
            出现的命令行参数的个数
        ARGIND
            当前正在处理的文件在ARGV中的索引
        ARGV
            命令行参数数组
        CONVFMT
            数字的转换格式（参见printf语句）。默认值为%.6g
        ENVIRON
            当前shell环境变量及其值的关联数组
        ERRNO
            当读取或关闭输入文件时发生错误时的系统错误
        FILENAME
            用于输入到gawk程序的数据文件的文件名
        FNR
            数据文件的当前记录号
        IGNORECASE
            如果设置为非0，则忽略gawk命令中使用的字符串的大小写
        NF
            数据文件中数据字段的个数
        NR
            已处理的输入记录的个数
        OFMT
            显示数字的输出格式。默认为%,6g
        RLENGTH
            匹配函数中匹配上的子字符串的长度
        RSTART
            匹配函数中匹配上的子字符串的开始索引
