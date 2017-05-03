# Selenium

[selenium](http://www.seleniumhq.org/) 是一个web程序自动化测试工具。由于selenium core是js编写，所以完全可以运行于各大浏览器，
可用于抓取网页中动态加载的数据。

## Selenium 版本

Selenium 现存两个版本一个叫selenium-core, 一个是selenium-rc

* selenium-core是使用html的方式来编写测试脚本，你可以使用selenium-ide来录制脚本

* selenium-rc 是selenium-remote control 缩写，是使用具体的语言来编写测试类

## Python 安装selenium

`sudo pip install -U selenium`

>安装完成后，[Selenium](https://pypi.python.org/pypi/selenium)还需要选择各浏览器的驱动接口，如Firefox 需要[feckodriver](https://github.com/mozilla/geckodriver/releases)
安装了之后才能运行，保证安装的目录在path中，放在/usr/bin 或者/usr/local/bin

## 查看selenium版本
```
$ python
Python 2.7.6 (default, Jun 22 2015, 17:58:13)
[GCC 4.8.2] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import selenium
>>> help(selenium)
```

## 抓取动态加载数据Demo-1

```
#!/usr/bin/env python
import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )

import os
from selenium import webdriver

chromedriver = "/usr/local/bin/chromedriver"
os.environ["webdriver.chrome.driver"] = chromedriver
driver = webdriver.Chrome(chromedriver)

driver.get("http://car.autohome.com.cn/config/series/413.html")
print driver.find_element_by_id('content').text
driver.quit()
```

>sys.setdefaultencoding( "utf-8" )不设置编码时会报错


## 模拟页面点击操作Demo-2

```
#!/usr/bin/env python
import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )
import os
from selenium import webdriver
chromedriver = "/usr/local/bin/chromedriver"
os.environ["webdriver.chrome.driver"] = chromedriver
driver = webdriver.Chrome(chromedriver)

driver.get("http://www.baidu.com")

driver.find_element_by_id("kw").send_keys("Selenium2")
driver.find_element_by_id("su").click()

driver.quit()
```




