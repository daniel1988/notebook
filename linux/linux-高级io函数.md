#高级I/O函数

Linux提供了pipe,dup,dup2,readv, writev, sendfile, mmap, munmap, splice, tee, fcntl等高级的I/O函数．它们不像Linux
基础I/O函数(open/read)那么常用，编写内核模块时一般才要实现这些函数．

* 用于创建文件描述符的函数有pipe, dup/dup2

* 用于读写数据的函数: readv/writev, sendfile, mmap/munmap, splice, tee

* 用于控制I/O行为的函数: fcntl

## pipe函数

pipe函数可用于创建一个管道,以实现进程间通信.

## dup/dup2

一般用于希望把标准输入/输出重定向到一个网络连接(CGI编程)

## readv/writev

readv函数是将数据从文件描述符读到分散的内存中，即分散读．writev函数则将多块分散的内存数据一并写入文件描述符中
即集中写

> Web服务器解析完一个http请求后，如果目标文档存在且客户有可读权限．这个http请求包含1个状态行，多个头部字段，
一个空行，和文档的内容．其中前３个部分的内容可能被web服务器放置在一块内存中，而文档的内容通常会读入到另外一个单独
的内存中(通过read函数或mmap函数).这时可以使用writev函数将它们同时写出

## sendfile

sendfile函数在两个文件描述符之间直接传递数据(完全内核操作)，从而避免了内核缓冲区和用户缓冲区之间的数据拷贝，效率很高
被称为零拷贝

## mmap/ munmap

mmap 函数用于申请一段内存空间．可以将这段内存作为进程间通信的共享内存，也可以将文件直接映射到其中．munmap函数则释放由
mmap创建的内存空间

## splice

用于两个文件描述符之间移动数据，也是零拷贝

## tee

在两个管道文件描述符之间复制数据，零拷贝

## fcntl

fcntl函数提供了对文件描述符的各种控制操作．另外一个常见的文件描述符属性和行为的系统调用是ioctl，而ioctl比fcntl能够执行
更多的控制．但是，对控制文件描述符常用的属性和行为，fcntl函数是由posix规范指定的首先方法
