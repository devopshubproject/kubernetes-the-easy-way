#!/bin/bash
set -x

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.88.20
#sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=198.168.33.14
#sudo kubectl taint nodes $(hostname) node-role.kubernetes.io/master:NoSchedule-

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.13.0/Documentation/kube-flannel.yml

#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

echo 'source <(kubectl completion bash)' >> $HOME/.bashrc
