
## tr 命令

tr命令可以对来处标准输入的字符进行替换，压缩和删除，它可以将一组字符变成另一组字符，经常用来编写优美的单行命令

* 语法

```
tr (选项) (参数)
```

** 选项

-c或--complerment      取代所有不属于第一字符集的字符
-d或--delete 删除所有属于第一字符集的字符
-s或--squeeze-repeats       把连续重复的字符以单独一个字符表达
-t或--truncate-set1  先删除第一个字符集第二字符集多出的字符


Demo1

```
echo "HELLO WORLD" | tr 'A-Z' 'a-z'
hello world
```

Demo2

```
echo "hello 123345"|tr -d '0-9'
hello
```