## zephir简介

zephir是一门可以编写和编译php拓展的脚本语言，它是动态/静态类型的语言，很多的特性跟php非常的相似

## 依赖
* gcc >= 4.x/clang >= 3.x
* re2c 0.13+
* gnu make 3.81+
* autoconf 2.31+
* automake 1.14+
* libpcre3
* php development headers and tools

```
$ sudo apt-get update
$ sudo apt-get install git gcc make re2c php5 php5-json php5-dev libpcre3-dev
```

## zephir　安装
```
$ git clone https://github.com/phalcon/zephir.git
$ cd zephir
$ bash install -c
$ zephir help

 _____              __    _
/__  /  ___  ____  / /_  (_)____
  / /  / _ \/ __ \/ __ \/ / ___/
 / /__/  __/ /_/ / / / / / /
/____/\___/ .___/_/ /_/_/_/
         /_/

Zephir version 0.9.6a-dev-aef205594b
```
> `bash install -c`　会把zephir/bin/zephir　拷贝到/usr/local/bin目录下

## php 拓展之hello world
```
$ cd /web/
$ mkdir zephir_test
$ zephir init hw

```
> 会发现hw 目录下面会有 ext/   hw/ config.json

在hw子目录下编写helloworld.zep文件
```
namespace Hw;

class HelloWorld
{
    public static function say()
    {
        var a = "hello world";
        echo strtoupper(a);
    }
}
```

`$ zephir build`

> 会发现ext/目录下已经生成了php拓展的c语言代码

```
$ cd ext
$ bash install
$ /web/zephir_test/hw/ext$ bash install
Configuring for:
PHP Api Version:         20131106
Zend Module Api No:      20131226
Zend Extension Api No:   220131226
Configuring for:
PHP Api Version:         20131106
Zend Module Api No:      20131226
Zend Extension Api No:   220131226
```
> 生成hw.so文件，　最后再加入php.ini

```
extenstion=hw.so
```

## 运行helloworld拓展
```
$ php -r "Hw\HelloWorld::say();"
HELLO WORLD
```

## zephir 生成的C语言代码在ext/hw/helloworld.zep.c
```
PHP_METHOD(Hw_HelloWorld, say) {

        zval *a = NULL, *_0;

        ZEPHIR_MM_GROW();

        ZEPHIR_INIT_VAR(a);
        ZVAL_STRING(a, "hello world", 1);
        ZEPHIR_INIT_VAR(_0);
        zephir_fast_strtoupper(_0, a);
        zend_print_zval(_0, 0);
        ZEPHIR_MM_RESTORE();

}
```



