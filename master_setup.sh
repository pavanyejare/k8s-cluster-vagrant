#!/bin/bash

## download calico yaml file 
mkdir   /root/k8s-cluster
cd /root/k8s-cluster
wget https://tinyurl.com/y2vqsobb -O calico.yaml
wget https://tinyurl.com/yb4xturm -O rbac-kdd.yaml


### For calico network
kubeadm init --apiserver-advertise-address=192.168.50.10 --pod-network-cidr=192.168.0.0/16 | tee kubeadm-init.out 
kubectl apply -f rbac-kdd.yaml
kubectl apply -f calico.yaml
###############

## For flannel Network
#kubeadm init --pod-network-cidr=10.240.0.0/16 --apiserver-advertise-address=192.168.50.10  | tee kubeadm-init.out 
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml
############
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

kubeadm token create --print-join-command | tee /root/k8s-cluster/join-worker
