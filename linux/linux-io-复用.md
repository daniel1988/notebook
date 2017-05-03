## I/O复用

I/O复用使得程序能同时监听多个文件描述符，这对提高程序的性能至关重要。通常网络程序在以下情况需要使用I/O复用技术：

* 客户端程序要同时处理多个socket。

* 客户端程序要同时处理用户输入和网络连接

* TCP服务器要同时处理监听socket和连接socket。这是I/O复用使用最多的场合

* 服务器要同时处理TCP请求和UDP请求

* 服务器要同时监听多个端口，或者处理多种服务

>Linux下实现I/O复用的系统调用主要有：select、poll、epoll

## 1、select 系统调用

select 系统调用的用途是：在一段指定时间内，监听用户感兴趣的文件描述符上的可读、可写和异常等事件
```
#include <sys/select.h>
int select(int nfds, fd_set* readfds, fd_set* writefds, fd_set* exceptfds, struct timeval* timeout);
```

* nfds 参数指定监听的文件描述符的总数

* readfds, writefds, exceptfds参数分别指向可读、可写和异常等事件对应的文件描述符集合



## 2、poll系统调用

poll系统调用和select类似，也是指定时间内轮询一定数据的文件描述符，以测试其中是否有就绪者

```
#include <poll.h>
int poll( struct pollfd* fds, nfds_t nfds, int timeout);
```

* fds 参数是一个pollfd结构类型的数组，它指定所有我们感兴趣的文件描述符上发生的可读、可写和异常等事件

* nfds参数指定被监听事件集合fds的大小

* timeout 参数指定poll的超时值单位是毫秒。当timeout 为-1时，poll调用将永远阻塞，直到某个事件发生;为0时，poll调用立即返回


## 3、epoll系列系统调用

epoll是Linux特有的I/O复用函数。它在实现和使用上与select、poll有很大的差异。首先，epoll使用一组函数来完成任务，而不是单个函数。其实，epoll把用户关心的文件描述符上的事件放在内核里的一个事件表中，从而无须像select和poll那样每次调用都要重复传入文件描述符集或者事件集。但epoll需要使用一个额外的文件描述符，来唯一标识内核中的这个事件表。


假设一个场合：100万用户同时与一个进程保持着TCP连接，而每个时刻只有几十个或者几百个TCP连接是活跃(接收TCP包)，也就是说每个时刻，进程只需要处理100万连接中一小部分连接。

>select与poll是直接把100万连接的套接字传给操作系统（用户态内存到内核态内存大量复制），而内核寻址也将是巨大的资源浪费。epoll不会这么做，而是在内核中申请一个简易的文件系统，把原先一个select或者poll调用分成３个部分：调用epoll_create建立一个epoll对象，调用epoll_ctl向epoll对象添加100万连接的套接字、调用epoll_wait收集发生事件的连接。这样只需要在进程启动建立1个epoll对象，并在需要的时候向它添加或者删除连接就可以了，因此，在实际收集事件时，epoll_wait的效率就非常高，因为调用epoll_wait时并没向它传递这100万个连接，内核也不需要去遍历全部的连接。


## select 、poll和epll 的区别

<table class="table table-bordered table-striped table-condensed">
    <tr>
        <td>系统调用</td>
        <td>select</td>
        <td>poll</td>
        <td>epoll</td>
    </tr>
    <tr>
        <td>事件集合</td>
        <td>用户通过3个参数分别传入感兴趣的可读、可写、异常等事件，内核通过对这些参数的在线修改来反馈其中的就绪事件。这使得用户每次调用select都要重置这3个参数</td>
        <td>统一处理所有事件类型，因此只需一个事件集参数。用户通过pollfd.events传入感兴趣的事件，内核通过修改pollfd.events反馈其中就绪的事件</td>
        <td>内核通过一个事件表直接管理用户感兴趣的所有事件。因此每次调用epoll_wait时，无须反复传入用户感兴趣的事件。epoll_wait系统调用的参数events仅用来反馈就绪的事件</td>
    </tr>
    <tr>
        <td>应用程序索引就绪文件描述符的时间复杂度</td>
        <td>O(n)</td>
        <td>O(n)</td>
        <td>O(1)</td>
    </tr>
    <tr>
        <td>最大支持文件描述符数</td>
        <td>一般有最大值限制</td>
        <td>65535</td>
        <td>65535</td>
    </tr>
    <tr>
        <td>工作模式</td>
        <td>LT</td>
        <td>LT</td>
        <td>支持ET高效模式</td>
    </tr>
    <tr>
        <td>内核实现和工作效率</td>
        <td>采用轮询方式来检测就绪事件，　O(n)</td>
        <td>轮询方式来检测，　O(n)</td>
        <td>采用回调方式来检测就绪事件，　O(1)</td>
    </tr>
</table>