#!/bin/bash
sudo su 
## Setup hosts
echo "192.168.50.10   master 
192.168.50.11   worker-1
192.168.50.12   worker-2" >> /etc/hosts


sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
service sshd restart

echo "admin123" | passwd --stdin root

########### Install Docker ############
yum remove docker* -y 
yum install -y yum-utils   device-mapper-persistent-data lvm2 wget sshpass
yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io

systemctl enable docker
systemctl start docker

## Disable selinux
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
setenforce 0 

systemctl stop firewalld
systemctl disable  firewalld

#Disable sawpoff
sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab
swapoff -a

# Install k8s repo and package
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

yum install -y kubeadm kubelet kubectl --disableexcludes=kubernetes

systemctl enable kubelet
systemctl start kubelet

# For CentOS and RHEL
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl net.bridge.bridge-nf-call-iptables=1
sysctl net.ipv4.ip_forward=1
sysctl --system
echo "1" > /proc/sys/net/ipv4/ip_forward

systemctl daemon-reload






