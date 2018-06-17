#!/usr/bin/env bash
#

sshlist=(
    "/home/danielluo/ssh_123.207.222.91.sh"
    "/home/danielluo/ssh_182.254.149.87.sh"
    "/home/danielluo/ssh_yingsdk_srv.sh"
)
select script in ${sshlist[@]};
do
    bash $script
done