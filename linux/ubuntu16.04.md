## Ubuntu 启动相关

* 设置命令行启动

```
sudo systemctl set-default multi-user.target

```

* 启动图型桌面
```
sudo systemctl start lightdm
```

* 设置默认图型界面启动

```
sudo systemctl set-default graphical.target
```