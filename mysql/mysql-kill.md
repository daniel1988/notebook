# 批量kill mysql 进程

```
echo "select concat('kill ', id,';') from information_schema.processlist where time>6000;" |mysql -uroot -proot|tail -n +2|mysql -uroot -proot
```