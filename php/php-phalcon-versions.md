# Phalcon 多版本切换


## clone cphalcon
```
git clone https://github.com/phalcon/cphalcon.git
```

>会加载所有版本大概130M左右

```
danielluo@danielluo:/data/cphalcon$ git branch -r
  origin/0.4.5
  origin/0.5.0
  origin/0.5.1
  origin/0.5.2
  origin/0.5.3
  origin/0.6.0
  origin/0.6.1
  origin/0.7.0
  origin/0.8.0
  origin/0.9.0
  origin/0.9.1
  origin/1.0.0
  origin/1.0.1
  origin/1.1.0
  origin/1.2.0
  origin/1.2.1
  origin/1.2.2
  origin/1.2.3
  origin/1.2.4
  origin/1.2.5
  origin/1.2.6
  origin/1.3.0
  origin/1.3.1
  origin/1.3.2
  origin/1.3.3
  origin/1.3.4
  origin/1.3.5
  origin/1.3.6
  origin/2.0.0
  origin/2.0.x
  origin/2.1.x
  origin/3.0.x
  origin/3.1.x
  origin/HEAD -> origin/master
  origin/master
  origin/mvc/view/test
  origin/revert-12226-cleaned_doc
```

## 切换版本

> 安装phalcon 1.3.6
```
$ cd /data/cphalcon/
$ git checkout origin/1.3.6
$ cd build
$ sudo bash install
```
> 重启服务器即可，* 1.*版本似乎没有phalcon tools