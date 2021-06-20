#!/bin/bash
set -x
#SLEEP_TIME="300"
vagrant up

rm join.sh; touch join.sh

#sleep ${SLEEP_TIME}

#cluster_token=$(vagrant ssh master -c 'kubeadm token create 2>/dev/null')
cluster_token=$(vagrant ssh master -c 'kubeadm token create --print-join-command')

#join_cmd="sudo kubeadm join 198.168.33.14:6443 --token ${cluster_token:0:-1} --discovery-token-unsafe-skip-ca-verification"
join_cmd="sudo ${cluster_token}"


cat <<EOF > join.sh
#!/bin/bash
$join_cmd
EOF

#sleep 60

vagrant plugin install vagrant-scp

vagrant scp ./join.sh node1:join.sh
vagrant ssh node1 -c 'chmod 777 join.sh'
vagrant ssh node1 -c "./join.sh"
#vagrant ssh node1 -c "$join_cmd"
#vagrant ssh node2 -c "$join_cmd"