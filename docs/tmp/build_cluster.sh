#!/bin/bash
set -x
SLEEP_TIME="300"
vagrant up

### ±±±±±±± To make kube master work
#vagrant plugin install vagrant-scp
#vagrant scp ./kubeconfig.sh master:kubeconfig.sh
#vagrant ssh master -c 'chmod 777 kubeconfig.sh'
#vagrant ssh master -c './kubeconfig.sh -y'

rm join.sh; touch join.sh

#sleep ${SLEEP_TIME}
#cluster_token=$(vagrant ssh master -c 'kubeadm token create 2>/dev/null')
#cluster_token=(vagrant ssh master -c 'kubeadm token create 2 > /dev/null')
cluster_token=$(vagrant ssh master -c 'kubeadm token create --print-join-command')
#join_cmd="sudo kubeadm join 192.168.88.20:6443 --token ${cluster_token:0:-1} --discovery-token-unsafe-skip-ca-verification"
#join_cmd="sudo kubeadm join 198.168.33.14:6443 --token ${cluster_token:0:-1} --discovery-token-unsafe-skip-ca-verification"
join_cmd="sudo ${cluster_token}"

#kubeadm token create --print-join-command > /vagrant/configs/join.sh

cat <<EOF > join.sh
#!/bin/bash
$join_cmd
EOF

#sleep 60
#vagrant ssh node1 -c '$join_cmd'
vagrant plugin install vagrant-scp

vagrant scp ./join.sh node1:join.sh
vagrant ssh node1 -c 'chmod 777 join.sh'
vagrant ssh node1 -c "./join.sh"
#vagrant ssh node1 -c "$join_cmd"
#vagrant ssh node1 -c "$join_cmd --v=5"
#vagrant ssh node2 -c "$join_cmd"
##vagrant ssh node1 -c 'sudo $cluster_token'
#vagrant ssh node2 -c "sudo $cluster_token"