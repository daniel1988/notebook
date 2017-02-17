#!/usr/bin/env python
# -*- coding:utf-8 -*-

import time
import sys,os


class ExportCsv:

    counter = -1

    def __init__(self, filename):

        csvfile = '/tmp/%s.%s.csv' % \
                  ( filename, time.strftime("%Y-%m-%d", time.localtime(time.time())) )

        print '-' * 80, '\n执行导出： %s' % filename

        dir = os.path.dirname(csvfile)
        if not os.path.isdir(dir):
            os.makedirs(dir, 0777)

        self.filename = filename
        self.csvfile  = csvfile
        self.fp       = open(csvfile, 'w')

    # 新增一行记录
    def add_row(self, *rows):
        self.counter = self.counter + 1
        if self.counter > 0 and self.counter % 100 is 0:
            self.stdout('\n' if self.counter % 10000 is 0 else '>')
        self.fp.write(unicode(self.csv_line(rows), 'gbk'))
    # 输出一行 csv 记录
    def csv_line(self, data):
        return '"' + '","'.join(unicode(str(x).replace('"', ''), 'UTF-8').encode('GB18030') for x in data) + '"\r\n'

    # 不换行输出消息
    def stdout(self, message):
        sys.stdout.write(message)
        sys.stdout.flush()

    # 保存导出结果
    def save(self):
        self.fp.flush()
        self.fp.close()

        print '\n导出成功：%s\n' % self.csvfile, '-' * 80


if __name__ == '__main__':
        export = ExportCsv('test_csv')
        export.add_row('A', 'B', 'C', 'D')
        export.add_row(1,2,3,4,6,7)

        export.save()


