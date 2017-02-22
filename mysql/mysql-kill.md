# 批量kill mysql 进程

```
echo "select concat('kill ', id,';') from information_schema.processlist where time>6000;" |mysql -uroot -proot|tail -n +2|mysql -uroot -proot

```


## kill Mysql Locked SQL

echo "select concat('kill ', id,';') from information_schema.processlist where state like '%Locked%';" |mysql -udc -p164214e804ec8 -S /tmp/mysql3306.sock|tail -n +2|mysql -udc -p164214e804ec8 -S /tmp/mysql3306.sock