#!/bin/bash
sleep 5m
sudo su - root
# instalar efs tools
yum install -y amazon-efs-utils
# Mount EFS
mkdir /efs
efs_id="${efs_id}"
mount -t efs $efs_id:/ /efs
#reboot a montagem automatico
echo $efs_id:/ /efs efs defaults,_netdev 0 0 >> /etc/fstab