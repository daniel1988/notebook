# GAWK

## 简介
    GNU AWK (GAWK) 是历史悠久的 AWK 编程语言的开放源代码实现，可用于所有的 UNIX® 系统。
AWK 语言是一种 UNIX 备用工具，它是一种功能强大的文本操作和模式匹配语言，特别适用于
进行信息检索，这使得它非常适合用于当今的数据库驱动的应用程序。因为它集成于 UNIX 环境，
所以可以设计、构建和快速地执行完整的工作程序，并且立即就能得到结果。

## AWK语言
    AWK 是该编程语言本身的名称，它编写于 1977 年。其名称是三个主要作者的姓的首字母缩写：
Drs. A. Aho、P. Weinberger 和 B. Kernighan。因为 AWK 是一种文本处理和模式匹配语言，所以
它通常称为数据驱动的 语言，程序语句描述需要进行匹配和处理的输入数据，而不是程序操作步骤的
序列，在许多语言中都是这样的。AWK 程序在其输入数据中搜索包含模式的记录、对该记录执行指定的
操作，直到程序到达输入的末尾。AWK 程序擅长于处理数据库和表型数据，如从多个数据集中提取一些列、
建立报表或分析数据。事实上，AWK 适合于编写短小的、一次性程序，以执行一些灵活的文本处理，
而使用其他的语言则可能成本较高。另外，作为一种功能强大的工具，AWK 常常在命令行中使用或与管道
一起使用。与 Perl（它起源于 AWK）一样，AWK 是一种解释性语言，所以 AWK 程序通常不需要进行编译。
相反，在运行时将程序脚本传递给 AWK 解释器。AWK 输入语言使用类似 C 语言的语法，这使得系统编程
人员感觉到非常的方便。事实上，其中许多特性，包括控制语句和字符串函数，如 printf 和 sprintf，
基本上是相同的。然而，也存在着一些差异。

## GAWK 的特性和优点
    * 在所有主要的 UNIX 平台以及其他操作系统中都可以使用它，包括 Mac OS X 和 Microsoft® Windows®。
    * 它是可移植操作系统接口 (POSIX) 兼容的，并且包含 1992 POSIX 标准中的所有特性。
    * 它没有预定义的内存限制。
    * 可以使用一些新的内置函数和变量。
    * 它包含一些特殊的 regexp 操作符。
    * 记录分隔符中可以包含 regexp 操作符。
    * 可以使用特殊文件支持来访问标准的 UNIX 流。
    * 可以使用 Lint 检查。
    * 在缺省情况下，它使用扩展的正则表达式。
    * 它支持无限制的行长度和连续使用反斜杠字符 (\)。
    * 它具有更好的、更具描述性的错误消息。
    * 它包含一些 TCP/IP 网络函数

### 目录
１、[gawk－简介](https://github.com/daniel1988/notebook/blob/master/linux/linux-gawk-1.md "linux-gawk")

２、[gawk－基础语法](https://github.com/daniel1988/notebook/blob/master/linux/linux-gawk-2.md "linux-gawk")

３、[gawk－运行、实例](https://github.com/daniel1988/notebook/blob/master/linux/linux-gawk-3.md "linux-gawk")