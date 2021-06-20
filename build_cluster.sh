#!/bin/bash
set -x
#SLEEP_TIME="300"
vagrant up

rm join.sh; touch join.sh

#sleep ${SLEEP_TIME}

cluster_token=$(vagrant ssh master -c 'kubeadm token create --print-join-command')

join_cmd="sudo ${cluster_token}"


cat <<EOF > join.sh
#!/bin/bash
set -x
$join_cmd
EOF

#sleep 60

vagrant plugin install vagrant-scp

vagrant scp ./join.sh node1:join.sh
vagrant ssh node1 -c 'chmod 777 join.sh'
vagrant scp ./node_init.sh node1:node_init.sh
vagrant ssh node1 -c 'chmod 777 node_init.sh'

vagrant scp ./join.sh node2:join.sh
vagrant ssh node2 -c 'chmod 777 join.sh'
vagrant scp ./node_init.sh node2:node_init.sh
vagrant ssh node2 -c 'chmod 777 node_init.sh'

vagrant ssh node1 -c "./node_init.sh"
vagrant ssh node2 -c "./node_init.sh"