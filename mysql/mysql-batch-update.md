# 批量修改各业务敏感字段

## 创建临时表－各业务敏感字段关系映射表
```
CREATE TABLE `encrypt_user_data` (
 `uid` int(11) unsigned NOT NULL COMMENT '用户id',
 `encrypt_bank_card_id` varchar(252) NOT NULL COMMENT '加密银行卡号',
 `encrypt_phone` varchar(252) NOT NULL COMMENT '加密手机号',
 `encrypt_contract_no` varchar(252) NOT NULL COMMENT 'encrypt_contract_no',
 `encrypt_email` varchar(252) NOT NULL COMMENT '加密邮箱',
 `encrypt_86_phone` varchar(252) NOT NULL COMMENT '加密带86手机号',
 `encrypt_name` varchar(252) NOT NULL COMMENT '加密用户名',
 `encrypt_identity_id` varchar(252) CHARACTER SET utf16 NOT NULL COMMENT '加密身份证',
 `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
 `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
 PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户敏感加密数据';
```
## 联表插入数据
```
INSERT IGNORE INTO encrypt_user_data
(uid,encrypt_bank_card_id,encrypt_phone,encrypt_contract_no,encrypt_email,encrypt_86_phone,encrypt_name,encrypt_identity_id)
SELECT b.uid AS uid,a.encrypted_bank_card_id AS encrypt_bank_card_id ,
    a.encrypted_phone AS encrypt_phone ,a.encrypted_contract_no AS encrypt_contract_no,
    b.email_safe AS encrypt_email,b.phone_safe AS encrypt_86_phone,c.encrypted_name AS encrypt_name,
    c.encrypted_identity_id AS encrypt_identity_id
FROM t_formax_user_info as b
LEFT JOIN t_bank_card_pay_info as a on b.uid=a.uid
LEFT JOIN t_user_base_info as c on b.uid=c.uid;
```
## 更新各业务敏感字段值
```
UPDATE customers,encrypt_user_data
SET customers.email=encrypt_user_data.encrypt_email,customers.phone=encrypt_user_data.encrypt_86_phone,
    customers.id_number=encrypt_user_data.encrypt_identity_id
WHERE customers.uid=encrypt_user_data.uid;
```