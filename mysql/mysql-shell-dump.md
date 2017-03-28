方案１：
danielluo@danielluo:/tmp$ mysql -uroot -proot -e"use xx_p2p;show tables;"
+----------------------+
| Tables_in_xx_p2p |
+----------------------+
| p2p_staff            |
| p2p_staff_salary     |
+----------------------+


方案２：

新建一个shell脚本，格式如下：
    #!/bin/bash      mysql -u* -h* -p* <<EOF          Your SQL script.      EOF
例如：

    #!/bin/bash      mysql -uroot  -ppassword
<<EOF         use chbdb;
    CREATE TABLE user (
        id varchar(36) NOT NULL COMMENT '主键',
        username varchar(50) NOT NULL COMMENT '用户名',
        password varchar(50) NOT NULL COMMENT '用户密码',
        createdate date NOT NULL COMMENT '创建时间',
        age int(11) NOT NULL COMMENT '年龄',
        PRIMARY KEY  (`id`)
    )
    ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';


方案３：

创建fos_crm.sql:
SET NAMES utf8;
SELECT B.project_name, C.activity_name, A.customer_uid, FROM_UNIXTIME(F.reg_time) AS reg_time,
FROM_UNIXTIME(G.distribute_create_time) AS dis_time, D.user_id, D.realname
FROM fos_crm.presale_distribute_customer A
    LEFT JOIN fos_crm.presale_project B ON A.project_id = B.project_id
    LEFT JOIN fos_crm.presale_activity C ON A.activity_id=C.activity_id
    LEFT JOIN xx_newcrm.sales D ON A.user_in_charge=D.user_id
    LEFT JOIN xx_newcrm.customers F ON A.customer_uid=F.uid
    LEFT JOIN fos_crm.presale_distribute G ON A.distribute_id = G.distribute_id
LIMIT 10;

mysql -uroot -proot < fos_crm.sql

导入数据到csv:
mysql -uroot -proot < fos_crm.sql >fos_crm.csv


方案４：

echo "set names utf8; select * from tbl_1;" | mysql -h127.0.0.1 -uroot -proot > xx.csv

