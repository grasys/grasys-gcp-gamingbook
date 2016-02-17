#!/bin/bash

yum -y update
yum -y install epel-release
yum -y install redis
sed -i -e "s/^bind 127.0.0.1$/bind 0.0.0.0/g" /etc/redis.conf

/etc/init.d/redis start

redis-cli set hostname `hostname`

cat <<EOF >>/etc/sysconfig/network-scripts/ifcfg-eth0:0
DEVICE="eth0:0"
BOOTPROTO="static"
IPADDR=10.1.1.1
NETMASK=255.255.255.255
ONBOOT="yes"
EOF

ifup eth0:0

