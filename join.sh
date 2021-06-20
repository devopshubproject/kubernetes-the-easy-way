#!/bin/bash
set -x
sudo kubeadm join 198.168.33.14:6443 --token o50xdk.znr130xxnbe1wjht --discovery-token-ca-cert-hash sha256:ca009a7933b5538526f88bc4c1d53b96638186b6ebbd9ce4f57cb27c390e03fc 
