#!/bin/bash

sshpass -p "admin123" scp -o StrictHostKeyChecking=no root@192.168.50.10:/root/k8s-cluster/join-worker .
sh join-worker 
