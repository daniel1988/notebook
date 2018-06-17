
# chromuim flash 安装

[下载flash](https://get.adobe.com/cn/flashplayer/)


## 解压

```
tar -zxvf xxxx.tar.gz
```

得到一个libpepflashplayer.so 文件


## 加入chromuin 的插件文件夹

```
sudo cp libpepflashplayer.so /usr/lib/chromuim-brower/plugins

```


## 在chromium 的启动选项中加入这一插件

```
sudo gedit /etc/chromium-browser/default
```

在flags 一行上加上

```
CHROMIUM_FLAGS="--ppapi-flash-path=/usr/lib/chromium-browser/plugins/libpepflashplayer.so --ppapi-flash-version=30.0.0.113"
```

version 可以从下载包中manifest.json文件里面看到