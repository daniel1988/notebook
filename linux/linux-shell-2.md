# Shell字符串

    * 单引号的任何字符都会原样输出，其中的变量是无效的
    * 双引号中可以有变量  可出现转义字符

## 拼接字符串

```
#!/usr/bin
name='xxoo'
str="hello,${name}"
echo str
```

## 获取字符串长度

```
#!/usr/bin
name='abcdefg'
echo ${#name} # 输出长度7
```

## 提取子字符串

```
#!/usr/bin
name='abcdefg'
echo ${name:1:4}    #输出：bcde
```

## 查找子字符串