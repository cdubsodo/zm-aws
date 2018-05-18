#! /bin/bash
mkdir -p /mnt/blockchain
echo "${file_system_id}:/ /mnt/blockchain efs tls,_netdev 0 0" >> /etc/fstab
mount -a -t efs defaults
chown ec2-user /mnt/blockchain

# mount new EBS volume
mkdir -p /mnt/ebs
mkfs -t ext4 /dev/sdh
echo "/dev/sdh /mnt/ebs  ext4   defaults,nofail" >> /etc/fstab
mount /dev/sdh /mnt/ebs
mkdir -p /mnt/ebs/zk1data
mkdir -p /mnt/ebs/zk1datalog

