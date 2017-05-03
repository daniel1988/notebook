#!/usr/bin/env python
import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )
import os
from selenium import webdriver
import argparse
import re

class WebSpider:

    driver = None

    def __init__(self):
        parser = argparse.ArgumentParser(description = 'WebSpider')
        parser.add_argument('-u', action='store', dest = 'url', type=str,
            help='python -u http://car.autohome.com.cn/config/series/413.html',
            default='http://car.autohome.com.cn/config/series/413.html')
        self.args = parser.parse_args()

    def init_driver(self):
        chromedriver = "/usr/local/bin/chromedriver"
        os.environ["webdriver.chrome.driver"] = chromedriver
        self.driver = webdriver.Chrome(chromedriver)
        return self.driver

    def get_html(self, url):
        print url
        driver = self.driver
        if driver is None:
            driver = self.init_driver()


        driver.get(url)
        html = driver.page_source

        # handler = open('/tmp/autohome.html', 'w')
        # handler.write(html)
        # handler.close()

        match = re.match(r'<div[\s|\S]*?id=[\'|"]content[\'|"]>([\s|\S]*?)<\/div>', html)
        print match
        if match is not None:
            print match.groups()

        driver.quit()


    def start(self):
        url = self.args.url
        self.get_html( url )

if __name__ == '__main__':
    WebSpider().start()
