#/usr/bin/evn bash

root=$(cd $(dirname $0); cd ..;pwd;)

chown -R nobody.nobody $0

# 需要清空的目录
rm_files=("data/cache/*" "data/metadata/*" "public/files/base-*.css")
for file in ${rm_files[@]};do
    file=$root/$file
    rm -rf $file
    echo "rm -rf ${file}"
done

# 需要创建的目录
mk_dirs=("data/logs" "data/metadata" "data/cache" "data/exports" "python/logs" "public/files")
for dir in ${mk_dirs[@]};do
    dir=$root/$dir
    if [ ! -d $dir ];then
        # mkdir -p $dir
        echo "mkdir -p ${dir}"
    fi
    # chown -R nobody.nobody $dir
    # chown -R 777 $dir
done

# 检测数据库配置文件
db_config_file=$root/app/config/production/database.php
if [ ! -f $db_config_file ];then
    echo -e "\033[31;49;2mMissing the configuration file for production environment: $db_config_file\033[39;49;0m"
fi

# 使 memcache 缓存全部过期
nc=/usr/bin/nc
if [ ! -f $nc ]; then
    yum -y install nc
fi
echo -n "Flush Memcache (127.0.0.1): "
echo 'flush_all' | nc 127.0.0.1 11211