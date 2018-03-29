
## 新增特性和改变

### 1. 标量类型和返回类型声明

`declare(strict_type=1)`开启时,会强制当前文件下的程序遵循严格的函数类型和返回类型

### 2. 更多的Error变为可捕获的Exception

php7实现了一个全局的throwable接口,原来的Exception和部分的Error都实现了这个接口

### 3. AST(Abstract Syntax Tree) 抽象语法树

AST在php编译过程作为一个中间件的角色,替换原来直接从解释器吐出opcode的方式,让解释器(parser)和编译器(compliler)解耦
可以减少一些hack代码,同时,让实现更容易理解和可维护

php5
```
php代码 --> Parser --> Opcode --> 执行
```
php7

```
php代码 --> Parser --> AST --> opcode --> 执行
```

### 4. Native TLS(native thread local storage) 原生线程本地存储

### 5. 其他新特性

- int64支持, 统一不同平台下的整形长度,字符串和文件上传都支持大于2GB
- 统一变量语法
- foreach 表现行为一致
- 新操作符  <=>  ??
- unicode 字符支持 (\u{xxxxx})
- 匿名类支持

## 跨越式的性能突破

### 1. JIT与性能

just in time (即时编译) 是一种软件优化技术,指在运行时才会去编译字节码. 从直觉出发,我们都很容易认为,机器码
是计算机能够直接识别和执行的,比起zend读取opcode逐条执行效率会更高.基中hhvm就是采用了JIT,让性能提升了一个数量级

```
php代码 --> Parser --> opcode ---> Zend引擎执行
```

```
php代码---> Parser ---> opcode --> typeInf ---> JIT ---> ByteCodes ---> 执行
```

在benchmark测试中提升了8倍.然后放入实际项目中时,却几乎看不见性能的提升.
因为JIT生成的ByteCodes如果太大,会引起CPU缓存命中率下降(cpu cache miss)


> CPU缓存命中是指,CPU在读取并执行指令的过程中, 如果需要的数据在CPU一级缓存(L1)中读不到, 会继续寻址到二级缓存(L2)和
三级缓存(L3)最终尝试到内存区域里寻找需要的指令数据. 而内存和cpu缓存之间的读取耗时差距达到100倍的级别. 所以bytecodes
如果过大,执行指令数量过多,导致多级缓存无法容纳如此之多的数据,部分指令将不得不被存放在内存区域


因此,CPU缓存命中率下降严重的耗时增加,另一方面, JIT带来的性能提升,也被它所抵消掉了.

> 通过JIT,可以降低VM的开销,同时通过指令优化,可以间接降低内存管理的开发,因为可以减少内存分配的次数. 但主要问题和瓶颈
并不在VM上,因上JIT优化计划,最后没有被列入php7的特性中,不过很有可能会在更后面的版本中实现


### 2. Zval的改变

php7中zval内存占16个字节，而php5中占据24个字节


### 3. 内部类型zend_string

zend_string是实际存储字符串的结构体，实际的内容会存储在val(char, 字符中), 而val是一个char数组，长度为1．而不是char*
这里有一个小优化技巧，可以降低cpu的cache miss

> 如果是使用char数组，当Malloc申请上述结构体内存，是申请在同一片区域的，通常是长度是sizeof(_zend_string)+实际char存储
空间．但是如果使用char* ，那这个位置存储的是一个指针，真实的存储又在另外一片独立的内存区域内．

### 4. php数组的变化(hash table 和zend array)

hashtable 存储的值需要指针跳转，有可能会导致cpu读取时，不在同一级缓存中而产生cpu cache miss .

php7 中使用zend array其中数组元素采用Bucket，使数组各元素分配在同一块内存中．不会再有指针外链．因而避免了
cpu cache miss

> zend array 的变化:
1. 数组的value默认为zval
2. hash table 的大小从72下降到56字节
3. buckets 的大小从72下降到32字节
4. 数组元素的buckets的内存空间是一同分配的
5. 数组元素key(bucket.key)指向zend_string
6. 数组元素的value被嵌入到Bucket中
7. 降低cpu cache miss

### 5. 函数调用机制

php7改进了函数的调用机制，通过优化参数传递的环节，减少了一些指令，提高执行效率．

* 6. 通过宏定义和内联函数(inline), 让编译器提前完成部分工作


