## 安装wubipingyin[参考](https://www.linuxdashen.com/ubuntu-16-04-%E5%A6%82%E4%BD%95%E5%AE%89%E8%A3%85fcitx%E4%BA%94%E7%AC%94%E6%8B%BC%E9%9F%B3%E8%BE%93%E5%85%A5%E6%B3%95)

```
sudo apt update
sudo apt install fcitx-table-wbpy fcitx-config-gtk
```

ubuntu 默认的输入法框架是ibus，需要切换为Fcitx输入框架
```
im-config -n fcitx
```


由于im-config所做的修改需要重启X窗口系统才能生效

```
sudo systemctl restart lightdm.service
```


## sublime text 中文 输入相关[参考](https://www.jianshu.com/p/c244ebc3893e)

* sublime-imfix.c

```
#include <gtk/gtkimcontext.h>
void gtk_im_context_set_client_window (GtkIMContext *context,
         GdkWindow    *window)
{
 GtkIMContextClass *klass;
 g_return_if_fail (GTK_IS_IM_CONTEXT (context));
 klass = GTK_IM_CONTEXT_GET_CLASS (context);
 if (klass->set_client_window)
   klass->set_client_window (context, window);
 g_object_set_data(G_OBJECT(context),"window",window);
 if(!GDK_IS_WINDOW (window))
   return;
 int width = gdk_window_get_width(window);
 int height = gdk_window_get_height(window);
 if(width != 0 && height !=0)
   gtk_im_context_focus_in(context);
}

```

* 安装c/c++编译环境

```
sudo apt-get install build-essential
sudo apt-get install libgtk2.0-dev
```

* 编译

```
gcc -shared -o libsublime-imfix.so sublime-imfix.c `pkg-config --libs --cflags gtk+-2.0` -fPIC
```

* 设置LD_PRELOAD并启动 Sublime

```
LD_PRELOAD=./libsublime-imfix.so subl
```

```
sudo mv libsublime-imfix.so /opt/sublime_text
```

* 修改/usr/bin/subl文件

```
#!/bin/sh
export LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so
exec /opt/sublime_text/sublime_text "$@"
```